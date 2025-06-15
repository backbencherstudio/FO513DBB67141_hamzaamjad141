import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/features/ebook_screen/presentation/widgets/wave_audio_slider/waveform_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/riverpod/audio_provider/audio_provider.dart';
import 'wave_audio_slider/waveform_slider.dart';

class AudioPlayerWidget extends ConsumerWidget {
  final String audioUrl;

  const AudioPlayerWidget({super.key, required this.audioUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(audioPlayerProvider(audioUrl));
    TextTheme textTheme = Theme.of(context).textTheme;
    generate();
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h, width: ScreenUtil().screenHeight),
          // Control buttons: Backward, Play/Pause, Forward
          if (!state.isLoading &&
              state.errorMessage == null &&
              state.totalDuration.inSeconds > 0)
            Column(
              children: [
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${state.currentPosition.inHours.toString().padLeft(2, '0')}:'
                      '${state.currentPosition.inMinutes.toString().padLeft(2, '0')}:'
                      '${(state.currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: textTheme.bodyMedium!.copyWith(color: AppColors.secondaryTextColor),

                    ),

                    Text(
                      '${state.totalDuration.inHours.toString().padLeft(2, '0')}:'
                      '${state.totalDuration.inMinutes.toString().padLeft(2, '0')}:'
                      '${(state.totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: textTheme.bodyMedium!.copyWith(color: AppColors.secondaryTextColor),
                    ),
                  ],
                ),
                SizedBox(height: 24.h, width: ScreenUtil().screenHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () => ref
                            .read(audioPlayerProvider(audioUrl).notifier)
                            .seekBackward(),
                        child: SvgPicture.asset(AppIcons.backwardAudio)),
                    IconButton(
                      icon: const Icon(Icons.fast_rewind, size: 40),
                      onPressed: () => ref
                          .read(audioPlayerProvider(audioUrl).notifier)
                          .seekBackward(),
                    ),
                    state.isLoading
                        ? const CircularProgressIndicator()
                        : state.errorMessage != null
                        ? Text(
                            state.errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                            ),
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
                    IconButton(
                      icon: const Icon(Icons.fast_forward, size: 40),
                      onPressed: () => ref
                          .read(audioPlayerProvider(audioUrl).notifier)
                          .seekForward(),
                    ),
                    GestureDetector(
                        onTap: () => ref
                            .read(audioPlayerProvider(audioUrl).notifier)
                            .seekForward(),
                        child: SvgPicture.asset(AppIcons.forwardAudio))
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}
