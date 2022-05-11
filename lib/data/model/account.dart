import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:simplio_app/data/model/account_settings.dart';
import 'package:simplio_app/data/model/account_wallet.dart';

class Account extends Equatable {
  static String generateSecret() {
    final ran = Random();
    final bytes = utf8.encode(ran.toString());

    return sha1.convert(bytes).toString();
  }

  final String id;
  final String secret;
  final String refreshToken;
  final DateTime lastLogin;
  final AccountSettings settings;
  final String defaultWallet;
  final List<AccountWallet> wallets;

  const Account._(
    this.id,
    this.secret,
    this.refreshToken,
    this.lastLogin,
    this.settings,
    this.defaultWallet,
    this.wallets,
  );

  const Account.builder({
    /// `id` is a Auth0 identifier. e.g apps@simplio.io
    required String id,

    /// `secret` is a generated string hash that is used for encrypting
    /// account sensitive data across application.
    required String secret,

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
          refreshToken,
          lastLogin,
          settings,
          defaultWallet,
          wallets,
        );

  @override
  List<Object> get props => [
        id,
      ];

  Account copyWith({
    String? refreshToken,
    DateTime? lastLogin,
    String? defaultWallet,
    AccountSettings? settings,
    List<AccountWallet>? wallets,
  }) {
    return Account._(
      id,
      secret,
      refreshToken ?? this.refreshToken,
      lastLogin ?? this.lastLogin,
      settings ?? this.settings,
      defaultWallet ?? this.defaultWallet,
      wallets ?? this.wallets,
    );
  }

  /// `unlock` is used to unlock secret with a provided key.
  /// key is usually a
  bool unlock(String key) {
    return secret == key;
  }
}
