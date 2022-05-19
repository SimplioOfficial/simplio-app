import 'package:crypto_assets/src/model/asset.dart';
import 'package:crypto_assets/src/model/asset_type.dart';
import 'package:crypto_assets/src/networks.dart';

import 'asset_details.dart';

class Assets {
  static Map<String, Asset> get enabled {
    final filteredEntries = Assets.all.entries.where((e) => e.value.enabled);
    return Map.fromEntries(filteredEntries);
  }

  static List<Asset> from(List<String> tickers) {
    return Assets.all.values
        .where((element) => tickers.contains(element.detail.ticker))
        .toList();
  }

  const Assets._();

  static const Map<String, Asset> all = {
    "simplio": Asset(
      detail: AssetDetails.simplio,
      assetTypes: [
        TokenAsset(contractAddress: '', network: Networks.solana),
      ],
    ),
    "bitcoin": Asset(
      detail: AssetDetails.bitcoin,
      assetTypes: [
        NativeAsset(network: Networks.bitcoin),
      ],
    ),
    "ethereum": Asset(
      detail: AssetDetails.ethereum,
      assetTypes: [
        NativeAsset(network: Networks.ethereum),
      ],
    ),
    "solana": Asset(
      detail: AssetDetails.solana,
      assetTypes: [
        NativeAsset(network: Networks.solana),
      ],
    ),
    "bitcoin-cash": Asset(
      detail: AssetDetails.bitcoinCash,
      assetTypes: [
        NativeAsset(network: Networks.bitcoinCash),
      ],
    ),
    "dogecoin": Asset(
      detail: AssetDetails.dogecoin,
      enabled: false,
      assetTypes: [
        NativeAsset(network: Networks.dogecoin),
      ],
    ),
    "dash": Asset(
      detail: AssetDetails.dash,
      assetTypes: [
        NativeAsset(network: Networks.dash),
      ],
    ),
    "digibyte": Asset(
      detail: AssetDetails.digibyte,
      assetTypes: [
        NativeAsset(network: Networks.digibyte),
      ],
    ),
    "litecoin": Asset(
      detail: AssetDetails.litecoin,
      assetTypes: [
        NativeAsset(network: Networks.litecoin),
      ],
    ),
    "zcash": Asset(
      detail: AssetDetails.zcash,
      assetTypes: [
        NativeAsset(network: Networks.zcash),
      ],
    ),
    "flux": Asset(
      detail: AssetDetails.flux,
      assetTypes: [
        NativeAsset(network: Networks.flux),
        TokenAsset(contractAddress: '', network: Networks.ethereum),
      ],
    ),
    "binance-usd": Asset(
      detail: AssetDetails.binanceUSD,
      assetTypes: [
        TokenAsset(contractAddress: '', network: Networks.binance),
      ],
    ),
    "chainlink": Asset(
      detail: AssetDetails.chainlink,
      assetTypes: [
        TokenAsset(contractAddress: '', network: Networks.solana),
        TokenAsset(contractAddress: '', network: Networks.ethereum),
        TokenAsset(contractAddress: '', network: Networks.binance),
      ],
    ),
  };
}
