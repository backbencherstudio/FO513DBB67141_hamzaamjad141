import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/e_book_model.dart';
import '../dummy_data.dart';

final ebookListProvider = Provider<List<EBook>>((ref) {
  return EbookList.map((e) => EBook.fromJson(e)).toList();
});

final ebookByIdProvider = Provider.family<EBook?, String>((ref, bookId) {
  final ebooks = ref.watch(ebookListProvider);
  try {
    return ebooks.firstWhere((book) => book.bookId == bookId,);
  } catch (e) {
    return null;
  }
});
