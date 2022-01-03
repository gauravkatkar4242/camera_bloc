part of 'response_page_camera_bloc.dart';

abstract class ResponsePageCameraEvent {
  const ResponsePageCameraEvent();
}

class InitializingControllerEvent extends ResponsePageCameraEvent {

}

class CameraReadyEvent extends ResponsePageCameraEvent {
}

class TimerStartedEvent extends ResponsePageCameraEvent {
  const TimerStartedEvent({required this.duration});

  final int duration;


}

class TimerTickedEvent extends ResponsePageCameraEvent {
  const TimerTickedEvent({required this.duration});

  final int duration;

}

class RecordingStoppedEvent extends ResponsePageCameraEvent {

}

class RecordingStartedEvent extends ResponsePageCameraEvent {

}

class DisposeCameraEvent extends ResponsePageCameraEvent {

}
