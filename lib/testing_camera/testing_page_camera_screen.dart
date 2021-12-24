import 'package:bloc_1/next_page_1.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'testing_page_camera_bloc.dart';

class TestingPageCameraScreen extends StatefulWidget
    with WidgetsBindingObserver {
  TestingPageCameraScreen({Key? key}) : super(key: key);

  @override
  State<TestingPageCameraScreen> createState() =>
      _TestingPageCameraScreenState();
}

class _TestingPageCameraScreenState extends State<TestingPageCameraScreen>
    with WidgetsBindingObserver {
  var cameraBloc;

  @override
  void didChangeDependencies() {
    cameraBloc = BlocProvider.of<TestingPageCameraBloc>(context)
      ..add(InitializingControllerEvent());
    WidgetsBinding.instance!.addObserver(this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    // context.read<TestingPageCameraBloc>().add(DisposeCameraEvent());
    print("disposed called======================");
    super.dispose();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TestingPageCameraBloc, TestingPageCameraState>(
      builder: (context, state) {
        // _controller = context.select((CameraBloc bloc) => bloc.state.cameraController);
        if (state is InitializationControllerState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CameraDisposedState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ControllerInitializationFailureState) {
          return const Center(
            child: Text("Issue in Camera Initialization"),
          );
        } else if (state is CameraExceptionState) {
          return FittedBox(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Video Recording Failed - Null video"),
                  const Text("Press Button to ReRecord"),
                  IconButton(
                      onPressed: () => context
                          .read<TestingPageCameraBloc>()
                          .add(InitializingControllerEvent()),
                      icon: const Icon(Icons.reset_tv_rounded))
                ],
              ),
            ),
          );
        } else {
          return LayoutBuilder(builder: (context, constraints) {
            var timer = context
                .select((TestingPageCameraBloc bloc) => bloc.state.timerDuration);
            return Stack(
              children: [
                kIsWeb
                    /* for camera screen web Button 👇*/
                    ? AspectRatio(
                        aspectRatio:
                            (constraints.maxWidth / constraints.maxHeight),
                        child:
                            CameraPreview(cameraBloc.state.cameraController!))

                    /* for camera screen mobile Button 👇*/
                    : Transform.scale(
                        scale: 1 /
                            (cameraBloc
                                    .state.cameraController!.value.aspectRatio *
                                (constraints.maxWidth / constraints.maxHeight)),
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            CameraPreview(cameraBloc.state.cameraController!),
                          ],
                        ),
                      ),

                /* for Start & Stop recording Button 👇*/
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state is! CameraReadyState ||
                              state is! RecordingInProgressState) ...[
                            Container(
                              height: 1,
                              width: 1,
                            )
                          ],
                          if (state is CameraReadyState) ...[
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.deepOrangeAccent),
                                  elevation: MaterialStateProperty.all(5.0)),
                              onPressed: () => context
                                  .read<TestingPageCameraBloc>()
                                  .add(RecordingStartedEvent()),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Start Recording",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.not_started_outlined)
                                ],
                              ),
                            ),
                          ],
                          if (state is RecordingInProgressState) ...[
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                  elevation: MaterialStateProperty.all(5.0)),
                              onPressed: () => context
                                  .read<TestingPageCameraBloc>()
                                  .add(RecordingStoppedEvent()),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Stop Recoding",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.stop_circle_outlined)
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
                /* for recording inProgress Icon 👇 */
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 8),
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (state is! RecordingInProgressState) ...[
                            Container(
                              height: 1,
                              width: 1,
                            )
                          ],
                          if (state is RecordingInProgressState) ...[
                            const Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 16.0,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black26,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 2),
                              child: const Text(
                                "REC",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: FittedBox(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                        if (state is !RecordingInProgressState) ...[
                          Container(
                            height: 1,
                            width: 1,
                          )
                        ],
                        if (state is RecordingInProgressState) ...[
                          Text(timer.toString(),style: TextStyle(fontSize: 20),)
                        ],
                      ])),
                )
              ],
            );
          });
        }
      },
      listener: (context, state) {
        print("******************************************************$state");
        if (state is RecordingCompletedState /* && kIsWeb */) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NextPage1(),
              ));
          context.read<TestingPageCameraBloc>().add(DisposeCameraEvent());
          // b1.close();
        }
        // else if(state is RecordingCompletedState){
        // }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      context.read<TestingPageCameraBloc>().add(DisposeCameraEvent());
      // Free up memory when camera not active
      print("------------------AppLifecycleState.inactive--------------------");
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      print("------------------AppLifecycleState.resumed--------------------");
      context.read<TestingPageCameraBloc>().add(InitializingControllerEvent());
    }
    // else if (state == AppLifecycleState.paused) {
    //   // Reinitialize the camera with same properties
    //   print("------------------AppLifecycleState.paused--------------------");
    //   context.read<TestingPageCameraBloc>().add(InitializingControllerEvent());
    // }
  }
}
