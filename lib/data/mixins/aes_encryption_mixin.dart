import 'package:encrypt/encrypt.dart';

mixin AesEncryption {
  Key _make32Key(String inp) {
    final keyStr = List.generate(32, (i) {
      try {
        return inp.split('').elementAt(i);
      } on RangeError {
        return '0';
      }
    }).join('');

    return Key.fromUtf8(keyStr);
  }

  String generateKey() {
    return Key.fromSecureRandom(32).base64;
  }

  String generateInitializationVector() {
    return IV.fromSecureRandom(16).base64;
  }

  String decrypt(String key, iv, base64Input) {
    final encrypter = Encrypter(
      AES(_make32Key(key)),
    );

    try {
      final decryptedString = encrypter.decrypt(
        Encrypted.fromBase64(base64Input),
        iv: IV.fromBase64(iv),
      );

      return decryptedString;
    } catch (e) {
      print(e);
      throw AesEncryptionException(e.toString());
    }
  }

  String encrypt(String key, iv, input) {
    final encrypter = Encrypter(
      AES(_make32Key(key)),
    );

    try {
      final encrypted = encrypter.encrypt(
        input,
        iv: IV.fromBase64(iv),
      );

      return encrypted.base64;
    } catch (e) {
      print(e);
      throw AesEncryptionException(e.toString());
    }
  }
}

class AesEncryptionException implements Exception {
  final String message;

  AesEncryptionException(this.message);
}
