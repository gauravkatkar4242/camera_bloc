part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();
}

class GettingCamerasEvent extends CameraEvent{

  @override
  List<Object> get props => [];
}

class InitializingControllerEvent extends CameraEvent{

  @override
  List<Object> get props => [];
}

class NotRecordingEvent extends CameraEvent{
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

