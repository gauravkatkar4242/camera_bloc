part of 'testing_page_camera_bloc.dart';

abstract class TestingPageCameraState extends Equatable {
  const TestingPageCameraState(this.cameraController,
      {this.timerDuration = 0});

  final CameraController? cameraController;
  final int timerDuration;
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


class TimerInitialState extends TestingPageCameraState {
  const TimerInitialState(CameraController? _controller, int duration)
      : super(_controller, timerDuration: duration);

  @override
  List<Object> get props => [];
}

class TimerRunInProgressState extends TestingPageCameraState {
  TimerRunInProgressState(CameraController? _controller, int duration)
      : super(_controller, timerDuration: duration);

  @override
  List<Object> get props => [timerDuration];
}


class RecordingInProgressState extends TestingPageCameraState{
  RecordingInProgressState(CameraController? _controller, int duration)
      : super(_controller, timerDuration: duration);

  @override
  List<Object> get props => [timerDuration];
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
