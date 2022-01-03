part of 'testing_page_camera_bloc.dart';

abstract class TestingPageCameraEvent {
  const TestingPageCameraEvent();
}

class InitializingControllerEvent extends TestingPageCameraEvent {}

class CameraReadyEvent extends TestingPageCameraEvent {}

class TimerStartedEvent extends TestingPageCameraEvent {
  const TimerStartedEvent({required this.duration});

  final int duration;
}

class TimerTickedEvent extends TestingPageCameraEvent {
  const TimerTickedEvent({required this.duration});

  final int duration;
}

class RecordingStoppedEvent extends TestingPageCameraEvent {}

class RecordingStartedEvent extends TestingPageCameraEvent {}

class DisposeCameraEvent extends TestingPageCameraEvent {}
