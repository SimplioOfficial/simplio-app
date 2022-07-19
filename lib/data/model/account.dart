import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:simplio_app/data/model/account_settings.dart';
import 'package:simplio_app/data/model/account_wallet.dart';
import 'package:simplio_app/data/model/lockable_string.dart';

part 'account.g.dart';

class Account extends Equatable {
  final String id;
  final AccountType accountType;
  final LockableString secret;
  final SecurityLevel securityLevel;
  // TODO - IDEA - Make failed passcode attemps persistent.
  final DateTime signedIn;
  final AccountSettings settings;
  final List<AccountWallet> wallets;

  const Account(
    this.id,
    this.accountType,
    this.secret,
    this.securityLevel,
    this.signedIn,
    this.settings,
    this.wallets,
  ) : assert(id.length > 0);

  const Account.registered({
    /// `id` is a Auth0 identifier. e.g apps@simplio.io
    required String id,

    /// [LockableSecret] is a generated string hash that is used for encrypting
    /// account sensitive data across application.
    required LockableString secret,
    SecurityLevel? securityLevel,
    required DateTime signedIn,
    AccountSettings settings = const AccountSettings.preset(),
    List<AccountWallet> wallets = const <AccountWallet>[],
  }) : this(
          id,
          AccountType.registered,
          secret,
          securityLevel ?? SecurityLevel.none,
          signedIn,
          settings,
          wallets,
        );

  Account.anonymous()
      : this(
          '', // TODO - IDEA - generate a custom id = uuid + date?
          AccountType.anonymous,
          LockableString.generate(),
          SecurityLevel.none,
          DateTime.now(),
          const AccountSettings.preset(),
          const <AccountWallet>[],
        );

  Account copyWith({
    SecurityLevel? securityLevel,
    DateTime? signedIn,
    AccountSettings? settings,
    List<AccountWallet>? wallets,
  }) {
    return Account(
      id,
      accountType,
      secret,
      securityLevel ?? this.securityLevel,
      signedIn ?? this.signedIn,
      settings ?? this.settings,
      wallets ?? this.wallets,
    );
  }

  @override
  List<Object?> get props => [
        id,
        accountType,
        secret,
        securityLevel,
        signedIn,
      ];

  AccountWallet? get accountWallet {
    if (wallets.isNotEmpty) return wallets.first;
    return null;
  }
}

// Account type split will be needed para showing the dashboard for anonymous
// users.
// TODO - Move it to related issue of Anonymous user.
@HiveType(typeId: 11)
enum AccountType {
  @HiveField(0)
  anonymous,

  @HiveField(1)
  registered,
}

// Security level handles navigating across app.
// If a user wont have any security level set, he must to set it first.
@HiveType(typeId: 12)
enum SecurityLevel {
  @HiveField(0)
  none,

  @HiveField(1)
  pin,
}

@HiveType(typeId: 1)
class AccountLocal extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final AccountType accountType;

  @HiveField(2)
  final String secret;

  @HiveField(3)
  final SecurityLevel securityLevel;

  @HiveField(4)
  final DateTime signedIn;

  @HiveField(5)
  final AccountSettingsLocal settings;

  @HiveField(6)
  final List<AccountWalletLocal> wallets;

  AccountLocal({
    required this.id,
    required this.accountType,
    required this.secret,
    required this.securityLevel,
    required this.signedIn,
    required this.settings,
    required this.wallets,
  });
}
