// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:package_service/package_service.dart';

void main() {
  group('PackageService', () {
    test('can be instantiated', () {
      expect(PackageService(), isNotNull);
    });
  });
}
