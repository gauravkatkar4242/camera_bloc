import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'camera_bloc.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Camera Page"),
        ),
        body: BlocConsumer(
            bloc: BlocProvider.of<CameraBloc>(context),
            builder: (context, state) {
                final controller = context.select((CameraBloc bloc) => bloc.state.cameraController);

                if (controller == null || !controller.value.isInitialized) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else {
                  return Stack(
                    children: [
                      CameraPreview(controller),
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: ElevatedButton(
                      //       style: ButtonStyle(
                      //         backgroundColor: _isRecordingInProgress
                      //             ? MaterialStateProperty.all<Color>(Colors.redAccent)
                      //             : MaterialStateProperty.all<Color>(Colors.deepOrange),
                      //       ),
                      //       onPressed: () {
                      //         _isRecordingInProgress
                      //             ? getRecordedVideo()
                      //             : startVideoRecording();
                      //       },
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Text(_isRecordingInProgress
                      //               ? "Stop Recording"
                      //               : "Start Recording",
                      //             style: TextStyle(fontSize: 16),),
                      //           Icon(_isRecordingInProgress
                      //               ? Icons.stop_circle_outlined
                      //               : Icons.not_started_outlined,),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // _isRecordingInProgress
                      //     ? Align(
                      //   alignment: Alignment.topLeft,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      //     child: Row(
                      //       children: const [
                      //         Icon(
                      //           Icons.circle,
                      //           color: Colors.red,
                      //           size: 16,
                      //         ),
                      //         Text(
                      //           " REC",
                      //           style: TextStyle(fontSize: 16),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                      //     : Container()
                    ],
                  );
                }

            },
            listener: (context, state) {
              print("******************************************************$state");
            }));
  }
}
