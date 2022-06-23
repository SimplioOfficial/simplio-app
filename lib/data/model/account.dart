import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:simplio_app/data/mixins/aes_encryption_mixin.dart';
import 'package:simplio_app/data/model/account_settings.dart';
import 'package:simplio_app/data/model/account_wallet.dart';

part 'account.g.dart';

class Account extends Equatable {
  final String id;
  final LockableSecret secret;
  final String? accessToken;
  final String refreshToken;
  final DateTime signedIn;
  final AccountSettings settings;
  final List<AccountWallet> wallets;

  const Account._(
    this.id,
    this.secret,
    this.accessToken,
    this.refreshToken,
    this.signedIn,
    this.settings,
    this.wallets,
  ) : assert(id.length > 0);

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
    required DateTime signedIn,
    AccountSettings settings = const AccountSettings.preset(),
    List<AccountWallet> wallets = const <AccountWallet>[],
  }) : this._(
          id,
          secret,
          accessToken,
          refreshToken,
          signedIn,
          settings,
          wallets,
        );

  Account copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? signedIn,
    AccountSettings? settings,
    List<AccountWallet>? wallets,
  }) {
    return Account._(
      id,
      secret,
      accessToken ?? this.accessToken,
      refreshToken ?? this.refreshToken,
      signedIn ?? this.signedIn,
      settings ?? this.settings,
      wallets ?? this.wallets,
    );
  }

  @override
  List<Object?> get props => [
        id,
        secret,
      ];

  AccountWallet? get accountWallet {
    if (wallets.isNotEmpty) return wallets.first;
    return null;
  }
}

class LockableSecret with AesEncryption {
  static String generateSecret() {
    return Hive.generateSecureKey().toString();
  }

  String _secret;
  bool _isLocked;

  LockableSecret._(this._secret, this._isLocked);

  LockableSecret.from({required String secret}) : this._(secret, true);

  LockableSecret.generate() : this._(LockableSecret.generateSecret(), false);

  bool get isLocked => _isLocked;

  String unlock(String key) {
    if (!_isLocked) return _secret;
    return decrypt(key, _secret);
  }

  LockableSecret lock(String key) {
    if (_isLocked) return this;

    _secret = encrypt(key, _secret);
    _isLocked = true;

    return this;
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
  final DateTime signedIn;

  @HiveField(4)
  final AccountSettingsLocal settings;

  @HiveField(5)
  final List<AccountWalletLocal> wallets;

  AccountLocal({
    required this.id,
    required this.secret,
    required this.refreshToken,
    required this.signedIn,
    required this.settings,
    required this.wallets,
  });
}
