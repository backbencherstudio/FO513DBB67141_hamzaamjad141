class PodcastApi {
  final String id;
  final String title;
  final String hostName;
  final DateTime date;
  final String mp3Url;
  final String coverUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  PodcastApi({
    required this.id,
    required this.title,
    required this.hostName,
    required this.date,
    required this.mp3Url,
    required this.coverUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert JSON response to Podcast model
  factory PodcastApi.fromJson(Map<String, dynamic> json) {
    return PodcastApi(
      id: json['id'],
      title: json['title'],
      hostName: json['hostName'],
      date: DateTime.parse(json['date']),
      mp3Url: json['mp3'],
      coverUrl: json['cover'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
