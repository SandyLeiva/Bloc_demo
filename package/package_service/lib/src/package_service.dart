
import 'dart:convert';

import 'package:http/http.dart' as http;

/// {@template package_service}
/// My new Flutter Service
/// {@endtemplate}
class PackageService {
  /// {@macro package_service}
  PackageService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();


  final http.Client _httpClient;

  final String base_Url = "api.giphy.com";
  final String endPoint = '/v1/gifs/trending';
  final String apiKey = '8xSnZL1qVrI8y9soSFsHehU0AcIjqH6d';

  Future<List<String>> fetchGifs() async {
    final uri = Uri.http(base_Url, endPoint, {'api_key': apiKey});
    http.Response response;
    List body;

    try{
      response = await _httpClient.get(uri);
    } on Exception {
      throw Exception();
    }

    if(response.statusCode != 200){
      throw HttpRequestException();
    }

    try{
      body = jsonDecode(response.body)['data'] as List;
    } on Exception {
      throw JsonDecodeException();
    }

    return body
        .map((url) => url['images']['original']['url'].toString())
        .toList();
  }
}

class HttpRequestException implements Exception {}
class JsonDecodeException implements Exception {}
