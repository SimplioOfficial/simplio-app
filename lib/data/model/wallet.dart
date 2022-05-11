import 'package:simplio_app/data/model/asset.dart';
import 'package:uuid/uuid.dart';

class Wallet {
  late String _uuid;
  final bool enabled;
  final Asset asset;

  String get uuid => _uuid;
  static const uuidGen = Uuid();

  Wallet(this._uuid, this.asset, this.enabled);

  Wallet.generate({required Asset asset})
      : this(uuidGen.v4(), asset, true);

  Wallet copyWith({ bool? enabled }) {
    return Wallet(
      uuid,
      asset,
      enabled ?? this.enabled,
    );
  }
}
