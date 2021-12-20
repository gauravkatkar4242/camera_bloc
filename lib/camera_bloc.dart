import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  var cameraList;
  CameraController? _controller;

  CameraBloc() : super(GetCameraState(null)) {
    on<CameraEvent>((event, emit) {
    });
    on<GettingCamerasEvent>(_getCameras);
    on<InitializingControllerEvent>(_initCamera);
    on<NotRecordingEvent>(_notRecoding);
    on<RecordingStartedEvent>(_startedRecording);
    on<RecodingStoppedEvent>(_getRecordedVideo);
  }


  Future<void> _getCameras(GettingCamerasEvent event, Emitter<CameraState> emit) async {

    print("_getCamera - STATE = $state");
    cameraList = await availableCameras(); // gets all available cameras from device
    emit(InitializationControllerState(_controller));
    add(InitializingControllerEvent());
  }

  Future<void> _initCamera(InitializingControllerEvent event, Emitter<CameraState> emit) async {

    print("_initCamera - STATE = $state");

    if (_controller != null) {
      await _controller!.dispose();
    }
    CameraDescription cameraDescription;
    if (cameraList.length == 1) {
      cameraDescription = cameraList[0];// for desktop
    } else {
      cameraDescription = cameraList[1]; // for mobile select front camera
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: true,
    );
    _controller = cameraController;

    if (cameraController.value.hasError) {
      emit(ControllerInitializationFailureState(null));
    }
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      emit(ControllerInitializationFailureState(null));
    }
    emit(ControllerInitializationSuccessfulState(_controller));
    emit(CameraReadyState(_controller));
  }


  void _notRecoding(NotRecordingEvent event, Emitter<CameraState> emit){
    print("_notRecoding - STATE = $state");
    emit(CameraReadyState(_controller));
  }

  Future<void> _startedRecording(RecordingStartedEvent event, Emitter<CameraState> emit) async {
    // _controller.startVideoRecording()
    print("_startedRecording - STATE = $state");

    if (_controller == null || _controller!.value.isRecordingVideo) {
      return;
    }
    try {
      await _controller!.startVideoRecording();
      emit(RecordingInProgressState(_controller));
    } on CameraException catch (e) {
    print("Error *** $e");
    }

  }

  Future<void> _getRecordedVideo(RecodingStoppedEvent event, Emitter<CameraState> emit) async {
    XFile? file = await _stoppedRecording();
    emit(RecordingCompletedState(_controller));

    if (file != null) {
      // file.saveTo("abd.mp4");
    }
    print(file?.path ?? "nulllll **************");
    emit(CameraReadyState(_controller));

  }

  Future<XFile?> _stoppedRecording() async{
    if (_controller == null || !_controller!.value.isRecordingVideo) {
      return null;
    }
    try {
      XFile file = await _controller!.stopVideoRecording();
      print("********************************************************${file.path}");
      print("_stoppedRecording - STATE = $state");
      return file;
    } on CameraException catch (e) {
      print("Error *** $e");
      return null;
    }
  }

}