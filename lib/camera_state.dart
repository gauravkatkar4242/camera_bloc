part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState(this.cameraController);
  final CameraController? cameraController;
}

// class CameraInitialState extends CameraState {
//   CameraInitialState(CameraController? cameraController) : super(cameraController);
//
//   @override
//   List<Object> get props => [];
// }

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

class CameraReadyState extends CameraState{
  CameraReadyState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class RecordingInProgressState extends CameraState{
  RecordingInProgressState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class RecordingCompletedState extends CameraState{
  RecordingCompletedState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

