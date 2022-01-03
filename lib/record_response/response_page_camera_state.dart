part of 'response_page_camera_bloc.dart';

abstract class ResponsePageCameraState extends Equatable {
  const ResponsePageCameraState(this.cameraController,
      {this.timerDuration = 0});

  final CameraController? cameraController;
  final int timerDuration;

  @override
  List<Object> get props => [timerDuration];
}

class InitializationControllerState extends ResponsePageCameraState {
  InitializationControllerState(CameraController? cameraController)
      : super(cameraController);
}

class ControllerInitializationFailureState extends ResponsePageCameraState {
  ControllerInitializationFailureState(CameraController? cameraController)
      : super(cameraController);
}

class CameraExceptionState extends ResponsePageCameraState {
  CameraExceptionState(CameraController? cameraController)
      : super(cameraController);
}

class CameraReadyState extends ResponsePageCameraState {
  const CameraReadyState(CameraController? cameraController)
      : super(cameraController);
}

class TimerInitialState extends ResponsePageCameraState {
  const TimerInitialState(CameraController? _controller, int duration)
      : super(_controller, timerDuration: duration);
}

class TimerRunInProgressState extends ResponsePageCameraState {
  TimerRunInProgressState(CameraController? _controller, int duration)
      : super(_controller, timerDuration: duration);
}

class RecordingInProgressState extends ResponsePageCameraState {
  RecordingInProgressState(CameraController? _controller, int duration)
      : super(_controller, timerDuration: duration);
}

class RecordingCompletedState extends ResponsePageCameraState {
  RecordingCompletedState(CameraController? cameraController)
      : super(cameraController);
}

class CameraDisposedState extends ResponsePageCameraState {
  CameraDisposedState(CameraController? cameraController)
      : super(cameraController);
}
