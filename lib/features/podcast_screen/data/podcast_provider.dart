import 'package:aviation_app/features/podcast_screen/data/dummy_data.dart';
import 'package:aviation_app/features/podcast_screen/model/podcast_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final podcastProvider = Provider<List<Podcast>>((ref) {
  return podcasts.map((e) => Podcast.fromJson(e)).toList();
});

final podcastByIdProvider = Provider.family<Podcast?, String>((ref, podcastId) {
  final podcast = ref.watch(podcastProvider);
  try {
    return podcast.firstWhere((podcast) => podcast.podcastId == podcastId,);
  } catch (e) {
    return null;
  }
});
