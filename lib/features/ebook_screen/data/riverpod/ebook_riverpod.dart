import 'package:aviation_app/features/ebook_screen/data/riverpod/ebook_api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/e_book_model.dart';

final ebookByIdProvider = Provider.family<EBook?, String>((ref, bookId) {
  final ebooks = ref.watch(ebookApiProvider).ebooks;
  try {
    return ebooks.firstWhere((book) => book.bookId == bookId);
  } catch (e) {
    return null;
  }
});
