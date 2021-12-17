part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  CameraState(this.cameraController);
  CameraController? cameraController;
}

class CameraInitialState extends CameraState {
  CameraInitialState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class GetCameraState extends CameraState {
  GetCameraState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class InitializationControllerState extends CameraState {
  InitializationControllerState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class ControllerInitializationSuccessfulState extends CameraState {
  ControllerInitializationSuccessfulState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class ControllerInitializationFailureState extends CameraState {
  ControllerInitializationFailureState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class RecordingStoppedState extends CameraState{
  RecordingStoppedState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

