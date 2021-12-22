part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();
}

class InitializingControllerEvent extends CameraEvent{

  @override
  List<Object> get props => [];
}

class CameraReadyEvent extends CameraEvent{
  @override
  List<Object> get props => [];
}

class RecodingStoppedEvent extends CameraEvent{
  @override
  List<Object> get props => [];
}

class RecordingStartedEvent extends CameraEvent{
  @override
  List<Object> get props => [];
}

class DisposeCameraEvent extends CameraEvent{
  @override
  List<Object> get props => [];
}
