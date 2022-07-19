import 'dart:convert';
import 'package:simplio_app/data/mixins/aes_encryption_mixin.dart';

/// Secret is marked with
/// `<secret>.d` for 'decrypted'.
/// `<secret>.e` for encrypted
/// `<secret>.c` for corrupted
const _corruptedSymbol = 'c';
const _encodedSymbol = 'e';
const _decodedSymbol = 'd';

enum SecretState {
  encoded(_encodedSymbol),
  decoded(_decodedSymbol),
  corrupted(_corruptedSymbol);

  final String symbol;
  const SecretState(this.symbol);

  @override
  String toString() {
    return symbol;
  }

  static SecretState fromSymbol(String symbol) {
    switch (symbol) {
      case _encodedSymbol:
        return SecretState.encoded;
      case _decodedSymbol:
        return SecretState.decoded;
      case _corruptedSymbol:
        return SecretState.corrupted;

      default:
        return SecretState.corrupted;
    }
  }
}

// TODO - test if lockable secret does not have a dot in generated string!
// TODO - run the test multiple times.
// TODO - test if generated secret is always decrepted.
// TODO - test if genrated secret is 32 bytes.
// TODO - test if every byte is lower than 255.
// TODO - test if separator is a dot.
// TODO - test if encrypted and decrepted secrets are not same.
// TODO - Write inline documentation.
class LockableString with AesEncryption {
  String? _unlockedValue;

  late SecretState _state;
  late String _value;
  late String _iv;

  LockableString.from({required String base64String}) {
    final bytes = base64.decode(base64String);
    final Map<String, dynamic> map = json.decode(utf8.decode(bytes));

    _value = map['value'] ?? '0';
    _iv = map['iv'] ?? '0';
    _state = SecretState.fromSymbol(
      map['state'] ?? SecretState.corrupted.symbol,
    );
  }

  LockableString.generate() {
    _iv = generateInitializationVector();
    _value = generateKey();
    _state = SecretState.decoded;
  }

  bool get isLocked => _state == SecretState.decoded;
  String? get unlockedValue {
    return _state == SecretState.decoded ? _value : _unlockedValue;
  }

  String unlock(String key, {bool keepUnlocked = true}) {
    if (_state == SecretState.decoded) return _value;
    if (_state == SecretState.encoded) {
      final decrypted = decrypt(key, _iv, _value);
      if (keepUnlocked) {
        _unlockedValue = decrypted;
      }

      return decrypted;
    }

    throw Exception('Your secret was corrupted');
  }

  LockableString lock(String key) {
    if (_state == SecretState.encoded) return this;

    _value = encrypt(key, _iv, _value);
    _state = SecretState.encoded;

    return this;
  }

  @override
  String toString() {
    final jsonStr = json.encode(<String, dynamic>{
      "state": _state.toString(),
      "value": _value,
      "iv": _iv,
    });
    return base64.encode(jsonStr.codeUnits);
  }
}
