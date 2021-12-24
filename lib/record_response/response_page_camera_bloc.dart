import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_1/record_response/timer.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'response_page_camera_event.dart';

part 'response_page_camera_state.dart';

class ResponsePageCameraBloc
    extends Bloc<ResponsePageCameraEvent, ResponsePageCameraState> {
  CameraController? _controller;

  final CountDownTimer _ticker = const CountDownTimer();

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    // dispose
    if (_controller != null) {
      _controller!.dispose();
    }
    _tickerSubscription?.cancel();
    return super.close();
  }

  ResponsePageCameraBloc() : super(InitializationControllerState(null)) {
    on<ResponsePageCameraEvent>((event, emit) {});
    on<InitializingControllerEvent>(_initCamera);
    on<CameraReadyEvent>(_notRecoding);
    on<TimerStartedEvent>(_onTimerStarted);
    on<TimerTickedEvent>(_onTicked);
    on<RecordingStartedEvent>(_startedRecording);
    on<RecordingStoppedEvent>(_getRecordedVideo);
    on<DisposeCameraEvent>(_disposeCamera);
  }

  Future<void> _initCamera(InitializingControllerEvent event,
      Emitter<ResponsePageCameraState> emit) async {
    print("_initCamera - STATE = $state");

    var cameraList =
        await availableCameras(); // gets all available cameras from device

    if (_controller != null) {
      await _controller!.dispose();
    }
    CameraDescription cameraDescription;
    if (cameraList.length == 1) {
      cameraDescription = cameraList[0]; // for desktop
    } else {
      cameraDescription = cameraList[1]; // for mobile select front camera
    }

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: true,
    );
    _controller = cameraController;

    if (cameraController.value.hasError) {
      emit(ControllerInitializationFailureState(null));
    }
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      emit(ControllerInitializationFailureState(null));
    }
    emit(CameraReadyState(_controller));
    add(const TimerStartedEvent(duration: -3));
  }

  void _notRecoding(
      CameraReadyEvent event, Emitter<ResponsePageCameraState> emit) {
    print("_notRecoding - STATE = $state");
    emit(CameraReadyState(_controller));
  }

  void _onTimerStarted(
      TimerStartedEvent event, Emitter<ResponsePageCameraState> emit) {
    emit(TimerRunInProgressState(_controller, event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTickedEvent(duration: duration)));
  }

  void _onTicked(
      TimerTickedEvent event, Emitter<ResponsePageCameraState> emit) {
    print("_onTicked ${event.duration}");

    if (event.duration < 0) {
      // emit(CameraReadyState(_controller));
      emit(TimerRunInProgressState(_controller, event.duration));
    } else if (event.duration == 0) {
      add(RecordingStartedEvent());
      // emit(RecordingInProgressState(_controller));
    } else if (event.duration > 10) {
      add(RecordingStoppedEvent());
    } else {
      emit(RecordingInProgressState(_controller, event.duration));
    }
  }

  Future<void> _startedRecording(RecordingStartedEvent event,
      Emitter<ResponsePageCameraState> emit) async {
    // _controller.startVideoRecording()
    print("_startedRecording - STATE = $state");

    if (_controller == null || _controller!.value.isRecordingVideo) {
      return;
    }
    try {
      await _controller!.startVideoRecording();
      emit(RecordingInProgressState(_controller, 0));
    } on CameraException catch (e) {
      //will set state to CameraExceptionState state
      emit(CameraExceptionState(_controller));
    }
  }

  Future<void> _getRecordedVideo(RecordingStoppedEvent event,
      Emitter<ResponsePageCameraState> emit) async {
    XFile? file = await _stoppedRecording();
    _tickerSubscription?.cancel();
    if (file == null) {
      emit(CameraExceptionState(_controller));
      return;
    }
    emit(RecordingCompletedState(_controller));
    if (file != null) {
      file.saveTo("abd.mp4");
    }
    emit(CameraReadyState(_controller));
  }

  Future<XFile?> _stoppedRecording() async {
    if (_controller == null || !_controller!.value.isRecordingVideo) {
      //will set state to CameraExceptionState state - Null video
      return null;
    }
    try {
      XFile file = await _controller!.stopVideoRecording();
      print(
          "********************************************************${file.path}");
      print("_stoppedRecording - STATE = $state");
      return file;
    } on CameraException catch (e) {
      //will set state to CameraExceptionState state
      return null;
    }
  }

  Future<void> _disposeCamera(
      DisposeCameraEvent event, Emitter<ResponsePageCameraState> emit) async {
    emit(CameraDisposedState(null));

    if (_controller != null) {
      await _controller?.dispose();
      print("Camera Disposed*****-*-------------***********------------0");
    }
    _tickerSubscription?.cancel();
  }
}
