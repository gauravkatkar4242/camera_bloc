import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraController? _controller;

  @override
  Future<void> close() {
    // dispose
    if (_controller != null){
      _controller!.dispose();
    }
    return super.close();
  }

  CameraBloc() : super(InitializationControllerState(null)) {
    on<CameraEvent>((event, emit) {});
    on<InitializingControllerEvent>(_initCamera);
    on<CameraReadyEvent>(_notRecoding);
    on<RecordingStartedEvent>(_startedRecording);
    on<RecodingStoppedEvent>(_getRecordedVideo);
    on<DisposeCameraEvent>(_disposeCamera);
  }

  Future<void> _initCamera(InitializingControllerEvent event, Emitter<CameraState> emit) async {

    print("_initCamera - STATE = $state");

    var cameraList = await availableCameras(); // gets all available cameras from device

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
    emit(CameraReadyState(_controller));
  }

  void _notRecoding(CameraReadyEvent event, Emitter<CameraState> emit) {
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
      //will set state to CameraExceptionState state
      emit(CameraExceptionState(_controller));

    }
  }

  Future<void> _getRecordedVideo(RecodingStoppedEvent event, Emitter<CameraState> emit) async {
    XFile? file = await _stoppedRecording();
    if (file == null){
      emit(CameraExceptionState(_controller));
      return;
    }
    emit(RecordingCompletedState(_controller));
    if (file != null) {
      // file.saveTo("abd.mp4");
    }
    emit(CameraReadyState(_controller));
  }

  Future<XFile?> _stoppedRecording() async{
    if (_controller == null || !_controller!.value.isRecordingVideo) {
      //will set state to CameraExceptionState state - Null video
      return null;
    }
    try {
      XFile file = await _controller!.stopVideoRecording();
      print("********************************************************${file.path}");
      print("_stoppedRecording - STATE = $state");
      return file;
    } on CameraException catch (e) {
      //will set state to CameraExceptionState state
      return null;
    }
  }

  Future<void> _disposeCamera(DisposeCameraEvent event, Emitter<CameraState> emit) async {
    emit(CameraDisposedState(null));

    if (_controller != null) {
      await _controller?.dispose();
      print("Camera Disposed*****-*-------------***********------------0");
    }
  }

}