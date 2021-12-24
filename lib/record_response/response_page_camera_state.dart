part of 'response_page_camera_bloc.dart';

abstract class ResponsePageCameraState extends Equatable {
  const ResponsePageCameraState(this.cameraController,
      {this.timerDuration = 0});

  final CameraController? cameraController;
  final int timerDuration;
}

class InitializationControllerState extends ResponsePageCameraState {
  InitializationControllerState(CameraController? cameraController)
      : super(cameraController);

  @override
  List<Object> get props => [];
}

class ControllerInitializationFailureState extends ResponsePageCameraState {
  ControllerInitializationFailureState(CameraController? cameraController)
      : super(cameraController);

  @override
  List<Object> get props => [];
}

class CameraExceptionState extends ResponsePageCameraState {
  CameraExceptionState(CameraController? cameraController)
      : super(cameraController);

  @override
  List<Object> get props => [];
}

class CameraReadyState extends ResponsePageCameraState {
  const CameraReadyState(CameraController? cameraController)
      : super(cameraController);

  @override
  List<Object> get props => [];
}

class TimerInitialState extends ResponsePageCameraState {
  const TimerInitialState(CameraController? _controller, int duration)
      : super(_controller, timerDuration: duration);

  @override
  List<Object> get props => [];
}

class TimerRunInProgressState extends ResponsePageCameraState {
  TimerRunInProgressState(CameraController? _controller, int duration)
      : super(_controller, timerDuration: duration);

  @override
  List<Object> get props => [timerDuration];
}

class RecordingInProgressState extends ResponsePageCameraState {
  RecordingInProgressState(CameraController? _controller, int duration)
      : super(_controller, timerDuration: duration);

  @override
  List<Object> get props => [timerDuration];
}

class RecordingCompletedState extends ResponsePageCameraState {
  RecordingCompletedState(CameraController? cameraController)
      : super(cameraController);

  @override
  List<Object> get props => [];
}

class CameraDisposedState extends ResponsePageCameraState {
  CameraDisposedState(CameraController? cameraController)
      : super(cameraController);

  @override
  List<Object> get props => [];
}
