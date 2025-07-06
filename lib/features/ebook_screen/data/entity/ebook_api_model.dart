class EbookApiModel {
  final String id;
  final String title;
  final String hostName;
  final DateTime date;
  final String pdf;
  final String cover;
  final DateTime createdAt;
  final DateTime updatedAt;

  EbookApiModel({
    required this.id,
    required this.title,
    required this.hostName,
    required this.date,
    required this.pdf,
    required this.cover,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'hostName': hostName,
      'date': date.toIso8601String(),
      'pdf': pdf,
      'cover': cover,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory EbookApiModel.fromJson(Map<String, dynamic> json) {
    return EbookApiModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      hostName: json['hostName'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      pdf: json['pdf'] ?? '',
      cover: json['cover'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
