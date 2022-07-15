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

  final accountLocal = AccountLocal(
      id: account.id,
      secret: account.secret.toString(),
      refreshToken: account.refreshToken,
      signedIn: account.signedIn,
      settings: const AccountSettingsLocal(
          themeMode: ThemeModeLocal.dark, languageCode: 'en'),
      wallets: const <AccountWalletLocal>[]);
  group('Account test', () {
    setUp(() {});

    test('Account id cannot be empty ', () {
      expect(account.id, isNotEmpty);
    });
    test('lockableSecret shouldnt be short', () {
      final lockableSecret = account.secret.toString();
      int secretLength =
          32; //It can't be a short string, but what is the minimum size?
      expect(lockableSecret.length > secretLength, true);
    });
    test('account id and accountLocal id should be equals', () {
      expect(account.id == accountLocal.id, true);
    });

    test('account secret accountLocal secret should be equals', () {
      final lockableSecret = account.secret.toString();
      expect(lockableSecret == accountLocal.secret, true);
    });

    //test('test encrypt', () { //fail test :(
    //  //incomplete
    //  var input = LockableSecret.generate();
    //  final key = LockableSecret.generateSecret();
    //  // final key = Hive.generateSecureKey().toString();
    //  var encrypt = input.lock(key); //error
    //  expect(encrypt = input, false);//
    // });
  });
}
