part of 'testing_page_camera_bloc.dart';

abstract class TestingPageCameraState extends Equatable {
  const TestingPageCameraState(this.cameraController);
  final CameraController? cameraController;
}

class InitializationControllerState extends TestingPageCameraState {
  InitializationControllerState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class ControllerInitializationFailureState extends TestingPageCameraState {
  ControllerInitializationFailureState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class CameraExceptionState extends TestingPageCameraState{
  CameraExceptionState(CameraController? cameraController) : super(cameraController);
  @override
  List<Object> get props => [];
}

class CameraReadyState extends TestingPageCameraState{
  CameraReadyState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class RecordingInProgressState extends TestingPageCameraState{
  RecordingInProgressState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class RecordingCompletedState extends TestingPageCameraState{
  RecordingCompletedState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}

class CameraDisposedState extends TestingPageCameraState{
  CameraDisposedState(CameraController? cameraController) : super(cameraController);

  @override
  List<Object> get props => [];
}
