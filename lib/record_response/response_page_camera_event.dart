part of 'response_page_camera_bloc.dart';

abstract class ResponsePageCameraEvent extends Equatable {
  const ResponsePageCameraEvent();
}

class InitializingControllerEvent extends ResponsePageCameraEvent{

  @override
  List<Object> get props => [];
}

class CameraReadyEvent extends ResponsePageCameraEvent{
  @override
  List<Object> get props => [];
}

class RecodingStoppedEvent extends ResponsePageCameraEvent{
  @override
  List<Object> get props => [];
}

class RecordingStartedEvent extends ResponsePageCameraEvent{
  @override
  List<Object> get props => [];
}

class DisposeCameraEvent extends ResponsePageCameraEvent{
  @override
  List<Object> get props => [];
}
