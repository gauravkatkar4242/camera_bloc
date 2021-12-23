import 'package:bloc_1/next_page_1.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'response_page_camera_bloc.dart';

class ResponsePageCameraScreen extends StatefulWidget with WidgetsBindingObserver {
  ResponsePageCameraScreen({Key? key}) : super(key: key);

  @override
  State<ResponsePageCameraScreen> createState() => _ResponsePageCameraScreenState();
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

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   cameraBloc = BlocProvider.of<CameraBloc>(context)
  //     ..add(InitializingControllerEvent());
  //   super.initState();
  // }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    context.read<ResponsePageCameraBloc>().add(DisposeCameraEvent());
    print("disposed called======================");
    super.dispose();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResponsePageCameraBloc, ResponsePageCameraState>(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is CameraReadyState) ...[
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.deepOrangeAccent),
                                elevation: MaterialStateProperty.all(5.0)),
                            onPressed: () => context
                                .read<ResponsePageCameraBloc>()
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
                                .read<ResponsePageCameraBloc>()
                                .add(RecodingStoppedEvent()),
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

                /* for recording inprogress Icon 👇 */
                Align(
                  alignment: kIsWeb ? Alignment.bottomRight : Alignment.topLeft,
                  child: Row(
                    children: [
                      if (state is RecordingInProgressState) ...[
                        Icon(Icons.circle),
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
        print("******************************************************$state");
        if (state is RecordingCompletedState) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const NextPage1(),
              ));
          // context.read<CameraBloc>().add(DisposeCameraEvent());
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
