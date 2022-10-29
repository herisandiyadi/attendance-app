import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyLat = 'lat';
  static const _keyLng = 'lng';
  static Future setLat(double? lat) async =>
      await _storage.write(key: _keyLat, value: lat.toString());
  static Future setLng(double? lng) async =>
      await _storage.write(key: _keyLng, value: lng.toString());

  static Future<String?> getLat() async => await _storage.read(key: _keyLat);
  static Future<String?> getLng() async => await _storage.read(key: _keyLng);
}
