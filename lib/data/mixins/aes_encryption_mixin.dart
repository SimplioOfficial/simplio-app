import 'dart:convert';
import 'dart:typed_data';

import 'package:hive/hive.dart';

mixin AesEncryption {
  static const int _offset = 128;

  String decrypt(String key, String input) {
    return HiveAesCipher(key.codeUnits)
        .decrypt(
          utf8.encoder.convert(input),
          _offset,
          key.length,
          Uint8List(0),
          _offset,
        )
        .toString();
  }

  String encrypt(String key, input) {
    return HiveAesCipher(key.codeUnits)
        .encrypt(
          utf8.encoder.convert(input),
          _offset,
          key.length,
          Uint8List(0),
          _offset,
        )
        .toString();
  }

  // TODO: missing logic
  bool isValid() {
    return false;
  }
}
