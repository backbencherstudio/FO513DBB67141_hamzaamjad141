import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/ebook_screen/data/mapping/ebook_mapping.dart';
import 'package:aviation_app/features/ebook_screen/model/e_book_model.dart';

import '../entity/ebook_state.dart';
import '../repository/ebook_repository.dart';
import '../entity/ebook_api_model.dart';

/// Ebook Provider (StateNotifier)
class EbookNotifier extends StateNotifier<EbookState> {
  final EbookRepository ebookRepository;
  final String? userToken;

  EbookNotifier(this.ebookRepository, this.userToken)
      : super(EbookState(ebooksApi: [], ebooks: []));

  /// Fetch ebooks method (with pagination and search query)
  Future<List<EbookApiModel>> fetchEbooks({
    required int page,
    required int limit,
    String? query,
  }) async {
    debugPrint('Fetching ebooks: page=$page, limit=$limit');

    state = state.copyWith(
      isLoading: page == 1,
      isFetching: page > 1,
      error: null,
    );

    try {
      List<EbookApiModel> newEbooksApi = await ebookRepository.getEbookApi(
        page: page,
        limit: limit,
        query: query,
        authToken: userToken ?? '',
      );

      debugPrint('Fetched ${newEbooksApi.length} ebooks for page $page');
      state = state.copyWith(
        ebooksApi: page == 1
            ? newEbooksApi
            : [...state.ebooksApi, ...newEbooksApi],
        isLoading: false,
        isFetching: false,
      );
      return newEbooksApi;
    } catch (e) {
      debugPrint('Error fetching ebooks: $e');
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
        isFetching: false,
      );
      return [];
    }
  }

  /// Load and map ebooks for initial load or reset
  Future<List<EBook>> loadEbooks({
    required int page,
    required int limit,
    String? query,
  }) async {
    debugPrint('Loading ebooks: page=$page, limit=$limit query=$query');

    final newEbooksApi = await fetchEbooks(page: page, limit: limit, query: query);

    if (newEbooksApi.isNotEmpty) {
      List<EBook> newEbooks = newEbooksApi
          .map((api) => EbookMapping.toEbook(api))
          .toList();

      state = state.copyWith(
        ebooks: page == 1 ? newEbooks : [...state.ebooks, ...newEbooks],
        currentPage: page,
        hasMore: newEbooks.length >= limit, // Check if more ebooks exist
      );
      return newEbooks;
    }

    state = state.copyWith(hasMore: false);
    return [];
  }

  /// Load more ebooks for pagination
  Future<void> loadMoreEbooks({required int limit}) async {
    if (state.isFetching || !state.hasMore) {
      debugPrint(
        'Skipping load: isFetching=${state.isFetching}, hasMore=${state.hasMore}',
      );
      return;
    }
    await loadEbooks(page: state.currentPage + 1, limit: limit);
  }

  /// Reset ebook list for new search
  void resetEbooks() {
    state = state.copyWith(
      ebooks: [],
      ebooksApi: [],
      currentPage: 1,
      hasMore: true,
    );
  }
}

/// Ebook API Provider
final ebookApiProvider =
StateNotifierProvider<EbookNotifier, EbookState>((ref) {
  final userToken = ref.watch(authProvider).userToken ?? '';
  final repository = EbookRepository();
  return EbookNotifier(repository, userToken);
});
