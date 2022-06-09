import 'package:crypto_assets/src/model/asset_detail.dart';
import 'package:crypto_assets/src/model/asset_type.dart';

import 'network.dart';

class Asset {
  final AssetDetail detail;
  final bool enabled;
  final List<AssetType> assetTypes;

  const Asset({
    required this.detail,
    this.enabled = true,
    required this.assetTypes,
  });

  Network getNetwork(int coinType) {
    return assetTypes
        .map((a) => a.network)
        .firstWhere((n) => n.coinType == coinType);
  }
}
