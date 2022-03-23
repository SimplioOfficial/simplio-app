import 'package:simplio_app/data/model/wallet_project.dart';
import 'package:uuid/uuid.dart';

class Wallet {
  late String _uuid;
  final bool enabled;
  final WalletProject project;

  String get uuid => _uuid;
  static const uuidGen = Uuid();

  Wallet(this._uuid, this.project, this.enabled);

  Wallet.generate({required WalletProject project})
      : this(uuidGen.v4(), project, true);

  Wallet copyWith({ bool? enabled }) {
    return Wallet(
      uuid,
      project,
      enabled ?? this.enabled,
    );
  }
}