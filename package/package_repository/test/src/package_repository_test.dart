// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:package_repository/package_repository.dart';

void main() {
  group('PackageRepository', () {
    test('can be instantiated', () {
      expect(PackageRepository(), isNotNull);
    });
  });
}
