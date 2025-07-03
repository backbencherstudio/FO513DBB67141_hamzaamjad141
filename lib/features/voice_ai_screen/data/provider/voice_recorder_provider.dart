import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class RecorderState {
  final bool isRecording;
  final String? errorMessage;
  final Duration? recordedTime;

  RecorderState({required this.isRecording, this.errorMessage, this.recordedTime});

  RecorderState copyWith({
    bool? isRecording,
    String? errorMessage,
    Duration? recordedTime,
  }) {
    return RecorderState(
      isRecording: isRecording ?? this.isRecording,
      errorMessage: errorMessage ?? this.errorMessage,
      recordedTime: recordedTime ?? this.recordedTime,
    );
  }
}

class RecorderNotifier extends StateNotifier<RecorderState> {
  late final FlutterSoundRecorder _audioRecorder;

  RecorderNotifier(Ref ref)
    : _audioRecorder = FlutterSoundRecorder(),
      super(RecorderState(isRecording: false, errorMessage: null)) {
    _initializeRecorder();
  }

  // Initialize recorder
  Future<void> _initializeRecorder() async {
    try {
      await _audioRecorder.openRecorder();
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to initialize recorder: $e');
    }
  }


  Future<String> _getFilePath() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/${DateTime.now().microsecond.toString()}.wav';
  }


  // Request microphone permission
  Future<bool> _requestPermissions() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      state = state.copyWith(errorMessage: 'Microphone permission denied');
      return false;
    }
    return true;
  }

  // Start recording
  Future<void> startRecording() async {
    if (state.isRecording) return;
    if (!await _requestPermissions()) return;

    try {
      final path = await _getFilePath();
      await _audioRecorder.startRecorder(toFile: path);
      state = state.copyWith(isRecording: true, errorMessage: null);
      if (state.isRecording) {
        for(int i = 0; i<i+1; i++){
          await Future.delayed(Duration(seconds: 1));
          state = state.copyWith(recordedTime: Duration(seconds: i));
          if(state.isRecording == false){
            state= state.copyWith(recordedTime: Duration(seconds: 0));
            break;
          }
        }
      }
      
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to start recording: $e');
    }
  }

  // Stop recording
  Future<void> stopRecording() async {
    if (!state.isRecording) return;

    try {
      await _audioRecorder.stopRecorder();
      state = state.copyWith(isRecording: false, errorMessage: null);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to stop recording: $e');
    }
  }

  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    super.dispose();
  }
}

// Define the Riverpod provider for the recorder state
final recorderProvider = StateNotifierProvider<RecorderNotifier, RecorderState>(
  (ref) {
    return RecorderNotifier(ref);
  },
);
