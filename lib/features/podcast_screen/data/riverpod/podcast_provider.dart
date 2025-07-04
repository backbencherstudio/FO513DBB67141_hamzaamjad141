import 'package:aviation_app/features/podcast_screen/data/riverpod/podcast_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/podcast_model.dart';

/// for audio fetching by id
final podcastByIdProvider = Provider.family<Podcast?, String>((ref, podcastId) {
  final podcasts = ref.watch(podcastApiProvider).podcasts;
  try {
    return podcasts.firstWhere((podcast) => podcast.podcastId == podcastId);
  } catch (e) {
    return null;
  }
});
