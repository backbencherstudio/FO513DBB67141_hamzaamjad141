class EBook {
  final String bookId;
  final String bookTitle;
  final DateTime publishDate;
  final String audioUrl;
  final String imageUrl;
  final String bookContent;
  final double progress;

  EBook({
    required this.bookId,
    required this.bookTitle,
    required this.publishDate,
    required this.audioUrl,
    required this.imageUrl,
    required this.bookContent,
    required this.progress,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'bookTitle': bookTitle,
      'publishDate': publishDate.toIso8601String(),
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'bookContent': bookContent,
      'progress': progress,
    };
  }

  factory EBook.fromJson(Map<String, dynamic> json) {
    return EBook(
      bookId: json['bookId'] as String,
      bookTitle: json['bookTitle'] as String,
      publishDate: DateTime.parse(json['publishDate']),
      audioUrl: json['audioUrl'] as String,
      imageUrl: json['imageUrl'] as String,
      bookContent: json['bookContent'] as String,
      progress: json['progress'] as double,
    );
  }
}
