import 'dart:developer';

import 'package:package_repository/src/models/gif_model.dart';
import 'package:package_service/package_service.dart';

/// {@template package_repository}
/// My new Flutter Repository
/// {@endtemplate}
class PackageRepository {
  /// {@macro package_repository}
  PackageRepository({PackageService? service})
      : _service = service ?? PackageService();

  final PackageService _service;

  Future<List<GifModel>> getUrls() async {
    final urls = <GifModel>[];
    try {
      final listUrls = await _service.fetchGifs();
      for (final url in listUrls) {
        urls.add(GifModel(url));
      }
      return urls;
    } catch (_) {
      throw Exception();
    }
  }

}
