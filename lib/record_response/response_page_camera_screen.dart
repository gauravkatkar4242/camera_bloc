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
  // @override
  @override
  Widget build(BuildContext context) {
    var cameraBloc = BlocProvider.of<ResponsePageCameraBloc>(context);
    return BlocConsumer<ResponsePageCameraBloc, ResponsePageCameraState>(
      builder: (context, state) {
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
            int timer = context.select(
                (ResponsePageCameraBloc bloc) => bloc.state.timerDuration);
            int min = (timer / 60).round();
            int sec = (timer % 60);
            return Stack(
              // alignment: Alignment.center,
              children: [
                kIsWeb
                    /* for camera screen web Button 👇*/
                    ? AspectRatio(
                        aspectRatio:
                            (constraints.maxWidth / constraints.maxHeight),
                        child:
                            // Expanded(child: CameraPreview(cameraBloc.state.cameraController!))
                            CameraPreview(cameraBloc.state.cameraController!))

                    /* for camera screen mobile Button 👇*/
                    : Transform.scale(
                        scale: 1 /
                            (cameraBloc
                                    .state.cameraController!.value.aspectRatio *
                                (constraints.maxWidth / constraints.maxHeight)),
                        alignment: Alignment.topCenter,
                        child:
                            CameraPreview(cameraBloc.state.cameraController!),
                      ),
                if (state is RecordingInProgressState) ...[
                  /* for Stop recording Button 👇*/
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: FittedBox(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              elevation: MaterialStateProperty.all(5.0)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  /* for timer 👇 */
                  Align(
                    alignment: Alignment.topRight,
                    child: FittedBox(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 12, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.black26,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            child: Text(
                              "${min.toString().padLeft(2, '0')} : ${sec.toString().padLeft(2, '0')}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                  )
                ],
                if (state is TimerRunInProgressState) ...[
                  /* for Timer before Starting Rec👇 */
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Recording Starts in ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          timer.abs().toString(),
                          style: const TextStyle(
                            fontSize: 75,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                /* for Timer before Starting Rec👇 */
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
          // context.read<ResponsePageCameraBloc>().add(DisposeCameraEvent());
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
