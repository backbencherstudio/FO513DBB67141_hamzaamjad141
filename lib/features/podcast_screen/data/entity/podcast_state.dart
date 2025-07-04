import '../../model/podcast_model.dart';
import 'podcast_data_model.dart';

/// Podcast State class
class PodcastState {
  final List<PodcastApi> podcastsApi;
  final List<Podcast> podcasts;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMore;
  final bool isFetching;

  PodcastState({
    required this.podcastsApi,
    required this.podcasts,
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
    this.isFetching = false,
  });

  // Copy with for state changes
  PodcastState copyWith({
    List<PodcastApi>? podcastsApi,
    List<Podcast>? podcasts,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMore,
    bool? isFetching,
  }) {
    return PodcastState(
      podcastsApi: podcastsApi ?? this.podcastsApi,
      podcasts: podcasts ?? this.podcasts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}
