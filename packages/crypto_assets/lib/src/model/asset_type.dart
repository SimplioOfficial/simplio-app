import 'package:crypto_assets/src/model/network.dart';

abstract class AssetType {
  final Network network;
  // final int decimal;

  const AssetType({
    required this.network,
    // required this.decimal,
  });
}

class TokenAsset extends AssetType {
  final String contractAddress;

  const TokenAsset({
    required this.contractAddress,
    // required int decimal,
    required Network network,
  }) : super(network: network);
}

class NativeAsset extends AssetType {
  const NativeAsset({
    required Network network,
  }) : super(network: network);
}
