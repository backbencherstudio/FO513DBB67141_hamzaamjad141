import 'package:aviation_app/features/ebook_screen/data/entity/ebook_api_model.dart';
import 'package:aviation_app/features/ebook_screen/model/e_book_model.dart';

class EbookState {
  final List<EbookApiModel> ebooksApi;
  final List<EBook> ebooks;
  final bool isLoading;
  final bool isFetching;
  final int currentPage;
  final bool hasMore;
  final String? error;

  EbookState({
    this.ebooksApi = const [],
    this.ebooks = const [],
    this.isLoading = false,
    this.isFetching = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.error,
  });

  EbookState copyWith({
    List<EbookApiModel>? ebooksApi,
    List<EBook>? ebooks,
    bool? isLoading,
    bool? isFetching,
    int? currentPage,
    bool? hasMore,
    String? error,
  }) {
    return EbookState(
      ebooksApi: ebooksApi ?? this.ebooksApi,
      ebooks: ebooks ?? this.ebooks,
      isLoading: isLoading ?? this.isLoading,
      isFetching: isFetching ?? this.isFetching,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      error: error,
    );
  }
}
