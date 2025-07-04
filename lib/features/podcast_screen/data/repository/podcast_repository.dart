import 'package:flutter/cupertino.dart';
import '../../../../core/services/api_services/api_services.dart';
import '../entity/podcast_data_model.dart';

class PodcastRepository {
  final ApiServices _apiServices = ApiServices.instance;

  /// Fetch podcasts from API
  Future<List<PodcastApi>> getPodcastsApi({
    required int page,
    required int limit,
    required String authToken,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      };

      debugPrint('headers: $headers');

      /// Make the API request with the headers
      final response = await _apiServices.getData(
        endPoint: 'portcusts/all?page=$page&limit=$limit',
        headers: headers,
      );

      List<dynamic> podcastList = response['data']['portcusts'];
      return podcastList
          .map((podcast) => PodcastApi.fromJson(podcast))
          .toList();
    } catch (e) {
      throw Exception("Error fetching podcasts: $e");
    }
  }
}
