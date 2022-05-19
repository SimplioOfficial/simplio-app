import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:simplio_app/data/model/account_settings.dart';
import 'package:simplio_app/data/model/account_wallet.dart';

part 'account.g.dart';

class Account extends Equatable {
  static String generateSecret() {
    return Hive.generateSecureKey().toString();
  }

  final String id;
  final LockableSecret secret; // asdfghjkweihdiu
  final String? accessToken;
  final String refreshToken;
  final DateTime lastLogin;
  final AccountSettings settings;
  final String defaultWallet;
  final List<AccountWallet> wallets;

  const Account._(
    this.id,
    this.secret,
    this.accessToken,
    this.refreshToken,
    this.lastLogin,
    this.settings,
    this.defaultWallet,
    this.wallets,
  );

  const Account.builder({
    /// `id` is a Auth0 identifier. e.g apps@simplio.io
    required String id,

    /// [LockableSecret] is a generated string hash that is used for encrypting
    /// account sensitive data across application.
    required LockableSecret secret,
    String? accessToken,

    /// `refreshToken` is a long-live token provided by Auth0. It is used
    /// only when authentication fails with `401` status.
    required String refreshToken,
    required DateTime lastLogin,
    AccountSettings settings = const AccountSettings.preset(),
    required String defaultWallet,
    List<AccountWallet> wallets = const <AccountWallet>[],
  }) : this._(
          id,
          secret,
          accessToken,
          refreshToken,
          lastLogin,
          settings,
          defaultWallet,
          wallets,
        );

  Account copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? lastLogin,
    String? defaultWallet,
    AccountSettings? settings,
    List<AccountWallet>? wallets,
  }) {
    return Account._(
      id,
      secret,
      accessToken ?? this.accessToken,
      refreshToken ?? this.refreshToken,
      lastLogin ?? this.lastLogin,
      settings ?? this.settings,
      defaultWallet ?? this.defaultWallet,
      wallets ?? this.wallets,
    );
  }

  @override
  List<Object?> get props => [
        id,
        secret,
      ];
}

class LockableSecret {
  static String generateSecret() {
    return Hive.generateSecureKey().toString();
  }

  static const int _offset = 128;

  String _secret;
  bool _isLocked;

  LockableSecret._(this._secret, this._isLocked);

  LockableSecret.from({required String secret}) : this._(secret, true);

  LockableSecret.generate() : this._(LockableSecret.generateSecret(), false);

  bool get isLocked => _isLocked;

  String unlock(String key) {
    if (!_isLocked) return _secret;
    return _decrypt(key);
  }

  LockableSecret lock(String key) {
    if (_isLocked) return this;

    _secret = _encrypt(key);
    _isLocked = true;

    return this;
  }

  String _decrypt(String key) {
    return HiveAesCipher(key.codeUnits)
        .decrypt(
          utf8.encoder.convert(key),
          _offset,
          key.length,
          Uint8List(0),
          _offset,
        )
        .toString();
  }

  String _encrypt(String key) {
    return HiveAesCipher(key.codeUnits)
        .encrypt(
          utf8.encoder.convert(key),
          _offset,
          key.length,
          Uint8List(0),
          _offset,
        )
        .toString();
  }

  bool isValid(String key) {
    return true;
  }

  @override
  String toString() {
    return _secret;
  }
}

@HiveType(typeId: 1)
class AccountLocal extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String secret;

  @HiveField(2)
  final String refreshToken;

  @HiveField(3)
  final DateTime lastLogin;

  @HiveField(4)
  final AccountSettingsLocal settings;

  @HiveField(5)
  final String defaultWallet;

  @HiveField(6)
  final HiveList<AccountWalletLocal> wallets;

  AccountLocal({
    required this.id,
    required this.secret,
    required this.refreshToken,
    required this.lastLogin,
    required this.settings,
    required this.defaultWallet,
    required this.wallets,
  });
}
