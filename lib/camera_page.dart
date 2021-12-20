
import 'package:bloc_1/next_page_1.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'camera_bloc.dart';

class CameraPage extends StatelessWidget with WidgetsBindingObserver {
  CameraPage({Key? key}) : super(key: key);

  // CameraController? _controller;

  var cameraBloc;
  @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   final CameraController? cameraController = _controller;
  //
  //   // App state changed before we got the chance to initialize.
  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     return;
  //   }
  //
  //   if (state == AppLifecycleState.inactive) {
  //     print("*******AppLifecycleState.inactive****************************");
  //     cameraController.dispose();
  //   } else if (state == AppLifecycleState.resumed) {
  //     // BlocProvider.of<CameraBloc>(context)..add(InitializingControllerEvent());
  //     // onNewCameraSelected(cameraController.description);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera Page"),
      ),
      body: BlocConsumer(
        bloc: BlocProvider.of<CameraBloc>(context)..add(GettingCamerasEvent()),
        builder: (context, state) {
          // _controller = context.select((CameraBloc bloc) => bloc.state.cameraController);

          if (state is InitializationControllerState || state is GetCameraState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Stack(
              children: [
                CameraPreview(context.select((CameraBloc bloc) => bloc.state.cameraController!)),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (state is CameraReadyState) ...[
                        IconButton(
                            onPressed: () => context
                                .read<CameraBloc>()
                                .add(RecordingStartedEvent()),
                            icon: const Icon(Icons.not_started_outlined))
                      ],
                      if (state is RecordingInProgressState) ...[
                        IconButton(
                            onPressed: () => context
                                .read<CameraBloc>()
                                .add(RecodingStoppedEvent()),
                            icon: const Icon(Icons.stop_circle_outlined))
                      ],
                    ],
                  ),
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          print("******************************************************$state");
          if (state is RecordingCompletedState){
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => NextPage1(),
          ));

        }
        },
      ),
    );
  }
}
