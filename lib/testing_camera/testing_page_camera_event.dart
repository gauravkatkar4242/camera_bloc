part of 'testing_page_camera_bloc.dart';

abstract class TestingPageCameraEvent extends Equatable {
  const TestingPageCameraEvent();
}

class InitializingControllerEvent extends TestingPageCameraEvent{

  @override
  List<Object> get props => [];
}

class CameraReadyEvent extends TestingPageCameraEvent{
  @override
  List<Object> get props => [];
}


class TimerStartedEvent extends TestingPageCameraEvent {
  const TimerStartedEvent({required this.duration});

  final int duration;

  @override
  List<Object> get props => [];
}

class TimerTickedEvent extends TestingPageCameraEvent {
  const TimerTickedEvent({required this.duration});

  final int duration;

  @override
  List<Object> get props => [];
}

class RecordingStoppedEvent extends TestingPageCameraEvent{
  @override
  List<Object> get props => [];
}

class RecordingStartedEvent extends TestingPageCameraEvent{
  @override
  List<Object> get props => [];
}

class DisposeCameraEvent extends TestingPageCameraEvent{
  @override
  List<Object> get props => [];
}
