import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

final audioPlayerProvider =
    StateNotifierProvider.family<AudioPlayerNotifier, AudioPlayerState, String>(
      (ref, audioUrl) {
        return AudioPlayerNotifier(audioUrl);
      },
    );

class AudioPlayerState {
  final bool isPlaying;
  final Duration currentPosition;
  final Duration totalDuration;
  final bool isLoading;
  final String? errorMessage;

  AudioPlayerState({
    required this.isPlaying,
    required this.currentPosition,
    required this.totalDuration,
    required this.isLoading,
    this.errorMessage,
  });

  AudioPlayerState copyWith({
    bool? isPlaying,
    Duration? currentPosition,
    Duration? totalDuration,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AudioPlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      currentPosition: currentPosition ?? this.currentPosition,
      totalDuration: totalDuration ?? this.totalDuration,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AudioPlayerNotifier extends StateNotifier<AudioPlayerState> {
  late AudioPlayer _audioPlayer;
  final String audioUrl;

  AudioPlayerNotifier(this.audioUrl)
    : super(
        AudioPlayerState(
          isPlaying: false,
          currentPosition: Duration.zero,
          totalDuration: Duration.zero,
          isLoading: true,
          errorMessage: null,
        ),
      ) {
    _audioPlayer = AudioPlayer();
    _setupListeners();
    _initializePlayer();
  }

  void _setupListeners() {
    _audioPlayer.onPlayerStateChanged.listen(
      (state) {
        if (mounted) {
          updateState(isPlaying: state == PlayerState.playing);
        }
      },
      onError: (error) {
        if (mounted) {
          updateState(
            errorMessage: 'Player State Error: $error',
            isLoading: false,
          );
        }
      },
    );

    _audioPlayer.onPositionChanged.listen(
      (position) {
        if (mounted) updateState(currentPosition: position);
      },
      onError: (error) {
        if (mounted) updateState(errorMessage: 'Position Error: $error');
      },
    );

    _audioPlayer.onDurationChanged.listen(
      (duration) {
        if (mounted) {
          updateState(
            totalDuration: duration,
            isLoading: (duration.inSeconds) <= 0,
          );
        }
      },
      onError: (error) {
        if (mounted) {
          updateState(errorMessage: 'Duration Error: $error', isLoading: false);
        }
      },
    );
  }

  Future<void> _initializePlayer() async {
    try {
      updateState(isLoading: true);
      // Try setting the source directly
      await _audioPlayer
          .setSource(UrlSource(audioUrl, mimeType: 'audio/mpeg'))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException(
                'Failed to set audio source',
              );
            },
          );
      await _audioPlayer.play(UrlSource(audioUrl, mimeType: 'audio/mpeg'));
      updateState(isLoading: false);
    } catch (e) {
      // Fallback: Download and play locally
      try {
        final response = await http.get(Uri.parse(audioUrl));
        if (response.statusCode == 200) {
          final directory = await getTemporaryDirectory();
          final file = File('${directory.path}/temp_audio.mp3');
          await file.writeAsBytes(
            response.bodyBytes,
          ); // Changed from writeBytes to writeAsBytes
          await _audioPlayer.setSourceDeviceFile(file.path);
          await _audioPlayer.play(DeviceFileSource(file.path));
          updateState(isLoading: false);
        } else {
          updateState(
            isLoading: false,
            errorMessage: 'Failed to download audio: ${response.statusCode}',
          );
        }
      } catch (downloadError) {
        updateState(
          isLoading: false,
          errorMessage:
              'Failed to initialize audio: $e, Download error: $downloadError',
        );
      }
    }
  }

  /* Future<void> _initializePlayer() async {
    if (state.isPlaying) {
      // If audio is already playing, don't reinitialize, just resume
      await _audioPlayer.resume();
      return;
    }

    // If the audio was paused or hasn't started yet, set it up
    await _audioPlayer.setSource(UrlSource(audioUrl, mimeType: 'audio/mpeg'));
    //_audioPlayer.play(source);
    //audioPlayer.play(UrlSource(audioUrl),volume: 1);
//    await _audioPlayer.resume();
  }*/

  void updateState({
    bool? isPlaying,
    Duration? currentPosition,
    Duration? totalDuration,
    bool? isLoading,
    String? errorMessage,
  }) {
    if (mounted) {
      state = state.copyWith(
        isPlaying: isPlaying,
        currentPosition: currentPosition,
        totalDuration: totalDuration,
        isLoading: isLoading,
        errorMessage: errorMessage,
      );
    }
  }

  void togglePlayPause() {
    if (state.isPlaying) {
      _audioPlayer.pause();
    } else {
      if (!state.isLoading && state.errorMessage == null) {
        _audioPlayer.resume();
      }
    }
  }

  void seekForward() {
    if (state.totalDuration.inSeconds > 0 &&
        state.currentPosition.inSeconds + 30 <= state.totalDuration.inSeconds) {
      final newPosition = state.currentPosition + const Duration(seconds: 30);
      _audioPlayer.seek(newPosition);
    }
  }

  void seekBackward() {
    if (state.totalDuration.inSeconds > 0 &&
        state.currentPosition.inSeconds - 15 >= 0) {
      final newPosition = state.currentPosition - const Duration(seconds: 15);
      _audioPlayer.seek(newPosition);
    }
  }

  void seekTo(double value) {
    if (state.totalDuration.inSeconds > 0) {
      final newPosition = Duration(seconds: value.toInt());
      _audioPlayer.seek(newPosition);
    }
  }

  @override
  bool get mounted => true; // Simplified for this context; in real use, track widget lifecycle

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
