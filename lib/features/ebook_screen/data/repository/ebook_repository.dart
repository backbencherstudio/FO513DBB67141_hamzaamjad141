import 'package:aviation_app/features/ebook_screen/data/entity/ebook_api_model.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/services/api_services/api_services.dart';

class EbookRepository {
  final ApiServices _apiServices = ApiServices.instance;

  Future<List<EbookApiModel>> getEbookApi({
    required int page,
    required int limit,
    required String authToken,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      };

      debugPrint('Headers: $headers');

      final response = await _apiServices.getData(
        endPoint: 'ebook/all?page=$page&limit=$limit',
        headers: headers,
      );

      debugPrint('API Response: $response');

      final List<dynamic> ebookList = response['data']?['ebooks'] ?? [];

      return ebookList
          .map((ebook) => EbookApiModel.fromJson(ebook as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Repository error: $e');
      throw Exception("Error fetching ebooks: $e");
    }
  }
}
