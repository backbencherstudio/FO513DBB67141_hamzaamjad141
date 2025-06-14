import 'package:aviation_app/features/ebook_screen/presentation/widgets/wave_audio_slider/waveform_painter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/riverpod/audio_provider/audio_provider.dart';
import 'wave_audio_slider/waveform_slider.dart';

class AudioPlayerWidget extends ConsumerWidget {
  final String audioUrl;

  const AudioPlayerWidget({super.key, required this.audioUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(audioPlayerProvider(audioUrl));
    generate();
    if (kDebugMode) {
      print(heightStore);
    }
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Control buttons: Backward, Play/Pause, Forward
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.fast_rewind, size: 40),
                onPressed: () => ref
                    .read(audioPlayerProvider(audioUrl).notifier)
                    .seekBackward(),
              ),
              const SizedBox(width: 20),
              state.isLoading
                  ? const CircularProgressIndicator()
                  : state.errorMessage != null
                  ? Text(
                      state.errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    )
                  : IconButton(
                      icon: Icon(
                        state.isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 40,
                      ),
                      onPressed: () => ref
                          .read(audioPlayerProvider(audioUrl).notifier)
                          .togglePlayPause(),
                    ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.fast_forward, size: 40),
                onPressed: () => ref
                    .read(audioPlayerProvider(audioUrl).notifier)
                    .seekForward(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (!state.isLoading &&
              state.errorMessage == null &&
              state.totalDuration.inSeconds > 0)
            Column(
              children: [
                Text(
                  '${state.currentPosition.inMinutes.toString().padLeft(2, '0')}:'
                  '${(state.currentPosition.inSeconds % 60).toString().padLeft(2, '0')} / '
                  '${state.totalDuration.inMinutes.toString().padLeft(2, '0')}:'
                  '${(state.totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 16),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: WaveformSlider(
                    currentPosition: state.currentPosition,
                    totalDuration: state.totalDuration,
                    onChanged: (position) => ref
                        .read(audioPlayerProvider(audioUrl).notifier)
                        .seekTo(position.inSeconds.toDouble()),
                    isEnabled: true,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
