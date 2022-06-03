import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';

class AccountRepository {
  final AccountDbProvider _db;

  const AccountRepository._(this._db);

  const AccountRepository.builder({
    required AccountDbProvider db,
  }) : this._(db);

  Future<AccountRepository> init() async {
    await _db.init();

    return this;
  }

  Future<Account> save(Account account) async {
    return _db.save(account);
  }

  Account? get(String id) {
    return _db.get(id);
  }
}
