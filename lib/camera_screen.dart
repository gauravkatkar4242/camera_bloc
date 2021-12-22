import 'package:bloc_1/next_page_1.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'camera_bloc.dart';

class CameraScreen extends StatefulWidget with WidgetsBindingObserver {
  CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  var cameraBloc;

  @override
  void didChangeDependencies() {
    cameraBloc = BlocProvider.of<CameraBloc>(context)
      ..add(InitializingControllerEvent());
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
    // cameraBloc.close();
    print("disposed called======================");
    // context.read<CameraBloc>().add(DisposeCameraEvent());
    super.dispose();
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CameraBloc, CameraState>(
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
                          .read<CameraBloc>()
                          .add(InitializingControllerEvent()),
                      icon: const Icon(Icons.reset_tv_rounded))
                ],
              ),
            ),
          );
        } else {
          return Stack(
            alignment: Alignment.center,
            children: [
              kIsWeb
                  ? AspectRatio(
                      aspectRatio: ((MediaQuery.of(context).size.width / 1.33) /
                          (MediaQuery.of(context).size.height)),
                      child: CameraPreview(cameraBloc.state.cameraController!))
                  // Text("${((MediaQuery.of(context).size.width / 1.33))} \n ${((MediaQuery.of(context).size.height))}"),)
                  : Transform.scale(
                      scale: 1 /
                          (cameraBloc
                                  .state.cameraController!.value.aspectRatio *
                              MediaQuery.of(context).size.aspectRatio),
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          CameraPreview(cameraBloc.state.cameraController!),
                        ],
                      ),
                    ),
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
                                  MaterialStateProperty.all<Color>(Colors.red),
                              elevation: MaterialStateProperty.all(5.0)),
                          onPressed: () => context
                              .read<CameraBloc>()
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
                                  MaterialStateProperty.all<Color>(Colors.red),
                              elevation: MaterialStateProperty.all(5.0)),
                          onPressed: () => context
                              .read<CameraBloc>()
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
                        ElevatedButton(
                          onPressed: () => context
                              .read<CameraBloc>()
                              .add(RecodingStoppedEvent()),
                          child: Row(
                            children: const [
                              Text("Stop Recoding "),
                              Icon(Icons.stop_circle_outlined)
                            ],
                          ),
                        )
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
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
          context.read<CameraBloc>().add(DisposeCameraEvent());
          // b1.close();
        }
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      print("------------------AppLifecycleState.inactive--------------------");
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      print("------------------AppLifecycleState.resumed--------------------");
      context.read<CameraBloc>().add(InitializingControllerEvent());
    } else if (state == AppLifecycleState.paused) {
      // Reinitialize the camera with same properties
      print("------------------AppLifecycleState.paused--------------------");
      context.read<CameraBloc>().add(DisposeCameraEvent());
    }
  }
}
