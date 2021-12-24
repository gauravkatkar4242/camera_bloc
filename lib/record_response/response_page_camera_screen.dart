import 'package:bloc_1/next_page_1.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'response_page_camera_bloc.dart';

class ResponsePageCameraScreen extends StatefulWidget
    with WidgetsBindingObserver {
  ResponsePageCameraScreen({Key? key}) : super(key: key);

  @override
  State<ResponsePageCameraScreen> createState() =>
      _ResponsePageCameraScreenState();
}

class _ResponsePageCameraScreenState extends State<ResponsePageCameraScreen>
    with WidgetsBindingObserver {
  var cameraBloc;

  @override
  void didChangeDependencies() {
    cameraBloc = BlocProvider.of<ResponsePageCameraBloc>(context)
      ..add(InitializingControllerEvent());
    WidgetsBinding.instance!.addObserver(this);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResponsePageCameraBloc, ResponsePageCameraState>(
      builder: (context, state) {
        var timer = context
            .select((ResponsePageCameraBloc bloc) => bloc.state.timerDuration);

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
                          .read<ResponsePageCameraBloc>()
                          .add(InitializingControllerEvent()),
                      icon: const Icon(Icons.reset_tv_rounded))
                ],
              ),
            ),
          );
        } else {
          return LayoutBuilder(builder: (context, constraints) {
            return Stack(
              // alignment: Alignment.center,
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
                        child: Expanded(
                            child: CameraPreview(
                                cameraBloc.state.cameraController!)),
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
                          if (state is! RecordingInProgressState) ...[
                            Container(
                              height: 1,
                              width: 1,
                            ),
                          ],
                          if (state is RecordingInProgressState) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red),
                                      elevation:
                                          MaterialStateProperty.all(5.0)),
                                  onPressed: () => context
                                      .read<ResponsePageCameraBloc>()
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
                            ),
                          ]
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

                /* for Timer before Starting Rec👇 */
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state is TimerRunInProgressState) ...[
                        Text(
                          timer.abs().toString(),
                          style: TextStyle(fontSize: 50),
                        ),
                      ]
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (state is RecordingInProgressState) ...[
                        Text(
                          timer.toString(),
                          style: TextStyle(fontSize: 50),
                        ),
                      ]
                    ],
                  ),
                )
              ],
            );
          });
        }
      },
      listener: (context, state) {
        print("--$state");
        if (state is RecordingCompletedState) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NextPage1(),
              ));
          context.read<ResponsePageCameraBloc>().add(DisposeCameraEvent());
          // b1.close();
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      context.read<ResponsePageCameraBloc>().add(DisposeCameraEvent());
      // Free up memory when camera not active
      print("------------------AppLifecycleState.inactive--------------------");
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      print("------------------AppLifecycleState.resumed--------------------");
      context.read<ResponsePageCameraBloc>().add(InitializingControllerEvent());
    }
  }
}
