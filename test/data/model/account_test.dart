import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/model/account_settings.dart';
import 'package:simplio_app/data/model/account_wallet.dart';
import 'package:mockito/mockito.dart';

void main() {
  final account = Account.builder(
      id: 'apps@simplio.io',
      secret: LockableSecret.generate(),
      accessToken: "2",
      refreshToken: "44",
      signedIn: DateTime(2022, 9, 7, 17, 30),
      settings: const AccountSettings.preset(),
      wallets: const <AccountWallet>[]);
  group('Account test', () {
    setUp(() {});

    test('Account id cannot be empty ', () {
      expect(account.id, isNotEmpty);
    });
    test('lockableSecret shouldnt be short', () {
      final lockableSecret = LockableSecret.generateSecret();
      int secretLength = 32;
      expect(lockableSecret.length > secretLength,
          true); //It can't be a short string, but what is the minimum size?
    });

    test('test encrypt', () {
      //incomplete
      var input = LockableSecret.generate();
      var key = LockableSecret.generateSecret();
      var output = input.lock(key); //error

      expect(output = input, false);
    });
  });
}
