import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'camera_event.dart';

part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  var cameraList;
  CameraController? _controller;

  CameraBloc() : super(CameraInitialState(null)) {
    on<CameraEvent>((event, emit) {
    });
    on<GettingCamerasEvent>(_getCameras);
    on<InitializingControllerEvent>(_initCamera);
  }


  Future<void> _getCameras(GettingCamerasEvent event, Emitter<CameraState> emit) async {

    print("_getCamera - STATE = $state");

    cameraList =
        await availableCameras(); // gets all available cameras from device
    emit(InitializationControllerState(_controller));
    add(InitializingControllerEvent());
  }

  Future<void> _initCamera(
      InitializingControllerEvent event, Emitter<CameraState> emit) async {

    print("_initCamera - STATE = $state");

    if (_controller != null) {
      await _controller!.dispose();
    }
    final CameraController cameraController = CameraController(
      cameraList[0],
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
  }
}
