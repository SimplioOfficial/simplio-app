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
        TokenAsset(
          contractAddress: '',
          network: Networks.solana,
          decimal: 10,
        ),
      ],
    ),
    "bitcoin": Asset(
      detail: AssetDetails.bitcoin,
      assetTypes: [
        NativeAsset(
          network: Networks.bitcoin,
          decimal: 10,
        ),
      ],
    ),
    "ethereum": Asset(
      detail: AssetDetails.ethereum,
      assetTypes: [
        NativeAsset(
          network: Networks.ethereum,
          decimal: 10,
        ),
      ],
    ),
    "solana": Asset(
      detail: AssetDetails.solana,
      assetTypes: [
        NativeAsset(
          network: Networks.solana,
          decimal: 10,
        ),
      ],
    ),
    "bitcoin-cash": Asset(
      detail: AssetDetails.bitcoinCash,
      assetTypes: [
        NativeAsset(
          network: Networks.bitcoinCash,
          decimal: 10,
        ),
      ],
    ),
    "dogecoin": Asset(
      detail: AssetDetails.dogecoin,
      enabled: false,
      assetTypes: [
        NativeAsset(
          network: Networks.dogecoin,
          decimal: 10,
        ),
      ],
    ),
    "dash": Asset(
      detail: AssetDetails.dash,
      assetTypes: [
        NativeAsset(
          network: Networks.dash,
          decimal: 10,
        ),
      ],
    ),
    "digibyte": Asset(
      detail: AssetDetails.digibyte,
      assetTypes: [
        NativeAsset(
          network: Networks.digibyte,
          decimal: 10,
        ),
      ],
    ),
    "litecoin": Asset(
      detail: AssetDetails.litecoin,
      assetTypes: [
        NativeAsset(
          network: Networks.litecoin,
          decimal: 10,
        ),
      ],
    ),
    "zcash": Asset(
      detail: AssetDetails.zcash,
      assetTypes: [
        NativeAsset(
          network: Networks.zcash,
          decimal: 10,
        ),
      ],
    ),
    "flux": Asset(
      detail: AssetDetails.flux,
      assetTypes: [
        NativeAsset(
          network: Networks.flux,
          decimal: 10,
        ),
        TokenAsset(
          contractAddress: '',
          network: Networks.ethereum,
          decimal: 10,
        ),
      ],
    ),
    "binance-usd": Asset(
      detail: AssetDetails.binanceUSD,
      assetTypes: [
        TokenAsset(
          contractAddress: '',
          network: Networks.binance,
          decimal: 10,
        ),
      ],
    ),
    "chainlink": Asset(
      detail: AssetDetails.chainlink,
      assetTypes: [
        TokenAsset(
          contractAddress: '',
          network: Networks.solana,
          decimal: 10,
        ),
        TokenAsset(
          contractAddress: '',
          network: Networks.ethereum,
          decimal: 10,
        ),
        TokenAsset(
          contractAddress: '',
          network: Networks.binance,
          decimal: 10,
        ),
      ],
    ),
  };
}
