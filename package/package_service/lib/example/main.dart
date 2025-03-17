import 'package:package_service/package_service.dart';

void main() async {
  final service = PackageService();

  final urls = await service.fetchGifs();
  for (final url in urls) {
    print(url);
  }
}
