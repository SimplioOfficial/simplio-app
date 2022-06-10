import 'package:crypto_assets/src/model/asset.dart';
import 'package:crypto_assets/src/model/asset_type.dart';
import 'package:crypto_assets/src/networks.dart' as networks;

import 'asset_details.dart' as asset_detail;

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
      detail: asset_detail.simplio,
      assetTypes: [
        TokenAsset(
          contractAddress: '',
          network: networks.solana,
          decimal: 10,
        ),
      ],
    ),
    "bitcoin": Asset(
      detail: asset_detail.bitcoin,
      assetTypes: [
        NativeAsset(
          network: networks.bitcoin,
          decimal: 10,
        ),
      ],
    ),
    "ethereum": Asset(
      detail: asset_detail.ethereum,
      assetTypes: [
        NativeAsset(
          network: networks.ethereum,
          decimal: 10,
        ),
      ],
    ),
    "solana": Asset(
      detail: asset_detail.solana,
      assetTypes: [
        NativeAsset(
          network: networks.solana,
          decimal: 10,
        ),
      ],
    ),
    "bitcoin-cash": Asset(
      detail: asset_detail.bitcoinCash,
      assetTypes: [
        NativeAsset(
          network: networks.bitcoinCash,
          decimal: 10,
        ),
      ],
    ),
    "dogecoin": Asset(
      detail: asset_detail.dogecoin,
      enabled: false,
      assetTypes: [
        NativeAsset(
          network: networks.dogecoin,
          decimal: 10,
        ),
      ],
    ),
    "dash": Asset(
      detail: asset_detail.dash,
      assetTypes: [
        NativeAsset(
          network: networks.dash,
          decimal: 10,
        ),
      ],
    ),
    "digibyte": Asset(
      detail: asset_detail.digibyte,
      assetTypes: [
        NativeAsset(
          network: networks.digibyte,
          decimal: 10,
        ),
      ],
    ),
    "litecoin": Asset(
      detail: asset_detail.litecoin,
      assetTypes: [
        NativeAsset(
          network: networks.litecoin,
          decimal: 10,
        ),
      ],
    ),
    "zcash": Asset(
      detail: asset_detail.zcash,
      assetTypes: [
        NativeAsset(
          network: networks.zcash,
          decimal: 10,
        ),
      ],
    ),
    "flux": Asset(
      detail: asset_detail.flux,
      assetTypes: [
        NativeAsset(
          network: networks.flux,
          decimal: 10,
        ),
        // TokenAsset(
        //   contractAddress: '0x720cd16b011b987da3518fbf38c3071d4f0d1495',
        //   network: networks.ethereum,
        //   decimal: 10,
        // ),
      ],
    ),
    "binance-usd": Asset(
      detail: asset_detail.binanceUSD,
      assetTypes: [
        TokenAsset(
          contractAddress: '0xe9e7cea3dedca5984780bafc599bd69add087d56',
          network: networks.binance,
          decimal: 10,
        ),
      ],
    ),
    "chainlink": Asset(
      detail: asset_detail.chainlink,
      assetTypes: [
        TokenAsset(
          contractAddress: 'CWE8jPTUYhdCTZYWPTe1o5DFqfdjzWKc9WKz6rSjQUdG',
          network: networks.solana,
          decimal: 10,
        ),
        TokenAsset(
          contractAddress: '0x514910771af9ca656af840dff83e8264ecf986ca',
          network: networks.ethereum,
          decimal: 10,
        ),
        TokenAsset(
          contractAddress: '0xf8a0bf9cf54bb92f17374d9e9a321e6a111a51bd',
          network: networks.binance,
          decimal: 10,
        ),
      ],
    ),
  };
}
