class Podcast {
  final String podcastId;
  final String title;
  final String hostName;
  final DateTime publishDate;
  final String audioUrl;
  final String imageUrl;
  final double progress;

  Podcast({
    required this.podcastId,
    required this.title,
    required this.hostName,
    required this.publishDate,
    required this.audioUrl,
    required this.imageUrl,
    required this.progress,
  });

  Map<String, dynamic> toJson() {
    return {
      'podcastId': podcastId,
      'title': title,
      'hostName': hostName,
      'publishDate': publishDate.toIso8601String(),
      'audioUrl': audioUrl,
      'imageUrl': imageUrl,
      'progress': progress,
    };
  }

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      podcastId: json['podcastId'] as String,
      title: json['title'] as String,
      hostName: json['hostName'] as String,
      publishDate: DateTime.parse(json['publishDate']),
      audioUrl: json['audioUrl'] as String,
      imageUrl: json['imageUrl'] as String,
      progress: json['progress'] as double,
    );
  }
}
