import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/ebook_screen/data/entity/ebook_api_model.dart';
import 'package:aviation_app/features/ebook_screen/data/repository/ebook_repository.dart';
import 'package:aviation_app/features/ebook_screen/data/mapping/ebook_mapping.dart';
import 'package:aviation_app/features/ebook_screen/model/e_book_model.dart';

import '../entity/ebook_state.dart';

class EbookNotifier extends StateNotifier<EbookState> {
  final EbookRepository ebookRepository;
  final String? userToken;

  EbookNotifier(this.ebookRepository, this.userToken)
      : super(EbookState());

  Future<List<EbookApiModel>> fetchEbooks({required int page, required int limit}) async {
    state = state.copyWith(
      isLoading: page == 1,
      isFetching: page > 1,
      error: null,
    );

    try {
      List<EbookApiModel> newEbooksApi = await ebookRepository.getEbookApi(
        page: page,
        limit: limit,
        authToken: userToken ?? '',
      );

      state = state.copyWith(
        ebooksApi: page == 1 ? newEbooksApi : [...state.ebooksApi, ...newEbooksApi],
        isLoading: false,
        isFetching: false,
      );

      return newEbooksApi;
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
        isFetching: false,
      );
      return [];
    }
  }

  Future<List<EBook>> loadEbooks({required int page, required int limit}) async {
    debugPrint('\n\n fetching data start............');
    final newEbooksApi = await fetchEbooks(page: page, limit: limit);

    if (newEbooksApi.isNotEmpty) {
      debugPrint('\n\n fetched: ${newEbooksApi.first}');
      List<EBook> newEbooks = newEbooksApi.map((api) => EbookMapping.toEbook(api)).toList();

      state = state.copyWith(
        ebooks: page == 1 ? newEbooks : [...state.ebooks, ...newEbooks],
        currentPage: page,
        hasMore: newEbooks.length >= limit,
      );
      return newEbooks;
    }

    debugPrint('\n\n No ebooks fetched');
    state = state.copyWith(hasMore: false);
    return [];
  }

  Future<void> loadMoreEbooks({required int limit}) async {
    if (state.isFetching || !state.hasMore) return;
    await loadEbooks(page: state.currentPage + 1, limit: limit);
  }
}

final ebookApiProvider = StateNotifierProvider<EbookNotifier, EbookState>((ref) {
  final userToken = ref.watch(authProvider).userToken;
  final repository = EbookRepository();
  return EbookNotifier(repository, userToken);
});
