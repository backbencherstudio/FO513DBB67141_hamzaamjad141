import '../../model/podcast_model.dart';
import '../entity/podcast_data_model.dart';

class PodcastMapping {
  final PodcastApi podcastApi;
  final Podcast? podcast;

  PodcastMapping({required this.podcastApi, required this.podcast});

  static Podcast toPodcast(PodcastApi podcastApi) {
    return Podcast(
      podcastId: podcastApi.id,
      title: podcastApi.title,
      hostName: podcastApi.hostName,
      publishDate: podcastApi.date,
      audioUrl: podcastApi.mp3Url,
      imageUrl: podcastApi.coverUrl,
      progress: 0.0,
    );
  }
}
