import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/podcast_screen/data/mapping/podcast_mapping.dart';
import 'package:aviation_app/features/podcast_screen/model/podcast_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/podcast_data_model.dart';
import '../entity/podcast_state.dart';
import '../repository/podcast_repository.dart';

/// Podcast Provider (StateNotifier)
class PodcastNotifier extends StateNotifier<PodcastState> {
  final PodcastRepository podcastRepository;
  final String userToken;
  PodcastNotifier(this.podcastRepository, this.userToken)
      : super(PodcastState(podcastsApi: [], podcasts: []));

  /// Fetch podcasts method
  Future<List<PodcastApi>> fetchPodcasts({
    required int page,
    required int limit,
    String? query,
  }) async {
    debugPrint('\nFetching podcasts: page=$page, limit=$limit\n');
    state = state.copyWith(
      isLoading: page == 1,
      isFetching: page > 1,
      error: null,
    );

    try {
      List<PodcastApi> newPodcastsApi = await podcastRepository.getPodcastsApi(
        page: page,
        limit: limit,
        query: query,
        authToken: userToken,
      );
      debugPrint('Fetched ${newPodcastsApi.length} podcasts for page $page');
      state = state.copyWith(
        podcastsApi: page == 1
            ? newPodcastsApi
            : [...state.podcastsApi, ...newPodcastsApi],
        isLoading: false,
        isFetching: false,
      );
      return newPodcastsApi;
    } catch (e) {
      debugPrint('Error fetching podcasts: $e');
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
        isFetching: false,
      );
      return [];
    }
  }

  /// Load and map podcasts for initial load or reset
  Future<List<Podcast>> loadPodcasts({
    required int page,
    required int limit,
    String? query,
  }) async {
    debugPrint('Loading podcasts: page=$page, limit=$limit query=$query');

    /// Fetch new podcasts
    final newPodcastsApi =
    await fetchPodcasts(page: page, limit: limit, query: query);

    /// Map new PodcastApi to Podcast
    if (newPodcastsApi.isNotEmpty) {
      List<Podcast> newPodcasts = newPodcastsApi
          .map((podcastApi) => PodcastMapping.toPodcast(podcastApi))
          .toList();
      debugPrint('Mapped ${newPodcasts.length} podcasts');
      state = state.copyWith(
        podcasts: page == 1 ? newPodcasts : [...state.podcasts, ...newPodcasts],
        currentPage: page,
        hasMore:
        newPodcasts.length >= limit, // Assume more data if limit is met
      );
      return newPodcasts;
    }
    debugPrint('No new podcasts loaded');
    state = state.copyWith(hasMore: false);
    return [];
  }

  /// Load more podcasts for pagination
  Future<void> loadMorePodcasts({required int limit}) async {
    if (state.isFetching || !state.hasMore) {
      debugPrint(
        'Skipping load: isFetching=${state.isFetching}, hasMore=${state.hasMore}',
      );
      return;
    }
    await loadPodcasts(page: state.currentPage + 1, limit: limit);
  }

  /// Reset podcast list for new search
  void resetPodcasts() {
    state = state.copyWith(
      podcasts: [],
      podcastsApi: [],
      currentPage: 1,
      hasMore: true,
    );
  }
}

final podcastApiProvider =
StateNotifierProvider<PodcastNotifier, PodcastState>(
      (ref) {
    final userToken = ref.watch(authProvider).userToken ?? "";
    final podcastRepository = PodcastRepository();
    return PodcastNotifier(podcastRepository, userToken);
  },
);
