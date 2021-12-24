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

class RecodingStoppedEvent extends TestingPageCameraEvent{
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
