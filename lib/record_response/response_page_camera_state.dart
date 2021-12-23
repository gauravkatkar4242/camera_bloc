part of 'response_page_camera_bloc.dart';

abstract class ResponsePageCameraState extends Equatable {
  const ResponsePageCameraState(this.cameraController);
  final CameraController? cameraController;
}

class InitializationControllerState extends ResponsePageCameraState {
  InitializationControllerState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class ControllerInitializationFailureState extends ResponsePageCameraState {
  ControllerInitializationFailureState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class CameraExceptionState extends ResponsePageCameraState{
  CameraExceptionState(CameraController? cameraController) : super(cameraController);
  @override
  List<Object> get props => [];
}

class CameraReadyState extends ResponsePageCameraState{
  CameraReadyState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class RecordingInProgressState extends ResponsePageCameraState{
  RecordingInProgressState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class RecordingCompletedState extends ResponsePageCameraState{
  RecordingCompletedState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class CameraDisposedState extends ResponsePageCameraState{
  CameraDisposedState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}
