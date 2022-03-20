import 'package:simplio_app/data/model/wallet_project.dart';
import 'package:uuid/uuid.dart';

class Wallet {
  late String _uuid;
  final bool active;
  final WalletProject project;

  String get uuid => _uuid;
  static const uuidGen = Uuid();

  Wallet(this._uuid, this.project, this.active);

  Wallet.generate({required WalletProject project})
      : this(uuidGen.v4(), project, true);

  Wallet copyWith({ bool? active }) {
    return Wallet(
      uuid,
      project,
      active ?? this.active,
    );
  }
}