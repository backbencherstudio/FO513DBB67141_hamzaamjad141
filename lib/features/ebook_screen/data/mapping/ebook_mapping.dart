import 'package:aviation_app/features/ebook_screen/data/entity/ebook_api_model.dart';
import 'package:aviation_app/features/ebook_screen/model/e_book_model.dart';

class EbookMapping {
  static EBook toEbook(EbookApiModel ebookApi) {
    return EBook(
      bookId: ebookApi.id,
      bookTitle: ebookApi.title,
      publishDate: ebookApi.date,
      imageUrl: ebookApi.cover,
      bookContent: ebookApi.pdf,
      progress: 0.0,
    );
  }
}
