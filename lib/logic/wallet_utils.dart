import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:sio_core/sio_core.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:crypto_assets/src/model/network.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class WalletUtils {
  static Future<BigInt> getBalance({
    required Network network,
    required String address,
    String? denomination,
    String? contractAddress,
    String? tokenMintAddress,
  }) {
    print('15 getBalance ${network.name} ${network.coinType}');
    switch (network.coinType) {
      // BTC
      case TWCoinType.TWCoinTypeBitcoin:
        return GetBalance.utxoCoinBlockbook(
          apiEndpoint: network.url,
          address: address,
        );

      // BNB Smart chain
      case TWCoinType.TWCoinTypeSmartChain:
        if (contractAddress == null) {
          return GetBalance.ethereumRPC(
            apiEndpoint: network.url,
            address: address,
          );
        }

        return GetBalance.ethereumERC20Scan(
          apiEndpoint: network.url,
          address: address,
          contractAddress: contractAddress,
        );

      // BCH
      case TWCoinType.TWCoinTypeBitcoinCash:
        return GetBalance.utxoCoinBlockbook(
          apiEndpoint: network.url,
          address: address,
        );

      // COSMOS
      case TWCoinType.TWCoinTypeCosmos:
        return GetBalance.cosmos(
          apiEndpoint: network.url,
          address: address,
          denomination: denomination ?? '',
        );

      case TWCoinType.TWCoinTypeDigiByte:
      case TWCoinType.TWCoinTypeDogecoin:
      case TWCoinType.TWCoinTypeDash:
        return GetBalance.utxoCoinBlockbook(
          apiEndpoint: network.url,
          address: address,
        );

      // ETH
      case TWCoinType.TWCoinTypeEthereum:
        if (contractAddress == null) {
          print(65);
          return GetBalance.ethereumRPC(
            apiEndpoint: network.url,
            address: address,
          );
        }

        print(72);
        return GetBalance.ethereumERC20Blockbook(
          apiEndpoint: network.url,
          address: address,
          contractAddress: contractAddress,
        );

      // ETC
      case TWCoinType.TWCoinTypeEthereumClassic:
        return GetBalance.ethereumBlockbook(
          apiEndpoint: network.url,
          address: address,
        );

      // FLUX
      case TWCoinType.TWCoinTypeZelcash:
        return GetBalance.utxoCoinInsight(
          apiEndpoint: network.url,
          address: address,
        );

      // LTC
      case TWCoinType.TWCoinTypeLitecoin:
        return GetBalance.utxoCoinBlockbook(
          apiEndpoint: network.url,
          address: address,
        );

      // OSMO
      case TWCoinType.TWCoinTypeOsmosis:
        return GetBalance.cosmos(
          apiEndpoint: network.url,
          address: address,
          denomination: 'uosmo',
        );

      // SOL
      case TWCoinType.TWCoinTypeSolana:
        if (tokenMintAddress == null) {
          return (GetBalance.solana(
            apiEndpoint: network.url,
            address: address,
          ));
        }

        return GetBalance.solanaToken(
          apiEndpoint: network.url,
          address: address,
          tokenMintAddress: tokenMintAddress,
        );

      // TERRA
      case TWCoinType.TWCoinTypeTerra:
        return GetBalance.cosmos(
          apiEndpoint: network.url,
          address: address,
          denomination: 'uluna',
        );

      // ZCASH
      case TWCoinType.TWCoinTypeZcash:
        return GetBalance.utxoCoinBlockbook(
          apiEndpoint: network.url,
          address: address,
        );

      default:
        print('136 ${network.coinType}');
        throw Exception('Unsupported coin type');
    }
  }

  static Future<BigInt> getAssetBalance(
      {required AssetWallet assetWallet, required HDWallet trustWallet}) async {
    BigInt balance = BigInt.zero;
    assetWallet.asset.assetTypes
        .map((assetType) async {
          return await WalletUtils.getBalance(
            network: assetType.network,
            address: trustWallet.getAddressForCoin(assetType.network.coinType),
          );
        })
        .toList()
        .forEach((element) async {
          balance = (balance + (await element));
          print('153 ${await element}');
        });

    print('158 $balance');
    return balance;
  }
}
