import '../data/model/account.dart';
import '../data/model/account_wallet.dart';
import '../data/model/asset_wallet.dart';
import '../data/model/wallet.dart';
import 'assets.dart';
import 'networks.dart';

/// Data Models
///
/// Account box
/// AssetWallets box
///
///
///
/// Account = Encrypted Box?
///    id: apps@simplio.io // UserId from Auth0
///    secret: generated_keys_encrypted_with_pin // secret encrypts seeds
///    accessToken: sdfghj.rghjk.ghjkl
///    refreshToken: dfghjkl
///    defaultWallet: jsdhjahd-idoqiwjd-kdjqwjdj-doqijdjj,
///    settings:
///    preferences:
///    wallets: <HiveList>[
///       AccountWallet
///         name: My multi-coin wallet
///         uuid: jsdhjahd-idoqiwjd-kdjqwjdj-doqijdjj
///         owner: apps@simplio.io // UserId from Auth0
///         walletType: MultiCoinWallet.seed
///         updatedAt: UTC timestamp
///
///       AccountWallet
///         name: My solana wallet
///         uuid: jsdhjahd-idoqiwjd-kdjqwjdj-doqijdj2
///         owner: apps@simplio.io // UserId from Auth0
///         walletType: SolanaWallet.seed
///         updatedAt: UTC timestamp
///     ]
///
///
/// AssetWallet:
///    name: Chainlink,
///    mid: jsdhjahd-idoqiwjd-kdjqwjdj-doqijdjj
///    ticker: CHAIN ,
///    enabled: true,
///    assetType [EthereumToken, SolanaToken]
///    wallets: <HiveList>[
///       Wallet:
///         uuid: dweuihd-dwehdhjk-dwhhuhhu-dwihduweu
///         mid: jsdhjahd-idoqiwjd-kdjqwjdj-doqijdjj
///         coinType: 102 // TWCoinType
///         network: Networks.ethereum
///         derivationPath: '',
///         balance: 200000000,
///       Wallet:
///         uuid: dweuihd-dwehdhjk-dwhhuhhu-dwihduweu
///         mid: jsdhjahd-idoqiwjd-kdjqwjdj-doqijdjj
///         coinType: 199 // TWCoinType
///         network: Networks.solana
///         derivationPath: '',  // Maybe not needed as TW store is in a file
///         balance: 9000000000,
///     ],
///
/// AssetWallet:
///    asset: Asset:
///       name: Solana,
///       ticker: SOL,
///       assetType [Solana]
///
///    name: Solana,
///    mid: jsdhjahd-idoqiwjd-kdjqwjdj-doqijdjj
///    ticker: SOL ,
///    enabled: false,
///    wallets: <HiveList>[
///       Wallet:
///         uuid: dweuihd-dwehdhjk-dwhhuhhu-dwihduweu
///         mid: jsdhjahd-idoqiwjd-kdjqwjdj-doqijdjj
///         type: 30 // TWCoinType
///         derivationPath: '',
///         balance: 1000000,
///     ],
///
/// CustomWallet:
///    name: Custom Shit,
///    mid: jsdhjahd-idoqiwjd-kdjqwjdj-doqijdjj
///    ticker: CUST ,
///    parent: SOL,
///    enabled: true,
///    contractAddress: 0x...,
///    networkType: 30,
///    balance: 1000000,
///

void main() {
  final ass = Assets.all["simplio"];

  var accountBOX = Account.builder(
    id: 'your_account1_id',
    secret: Account.generateSecret(),
    refreshToken: 'Refresh',
    lastLogin: DateTime.now(),
    defaultWallet: 'account_wallet_uuid',
    wallets: [
      AccountWallet.builder(
        name: 'Multicoin wallet 1',
        accountId: 'your_account1_id',
        walletType: MultiCoinWallet(mnemonic: 'do not show your seed ...'),
        updatedAt: DateTime.now(),
        enabled: true,
      ),
    ],
  );

  var assetWalletsBOX = [
    AssetWallet.builder(
      assetId: 'simplio',
      accountWalletId: accountBOX.id,
      asset: ass!,
      enabled: true,
      wallets: [
        Wallet.builder(
          coinType: 20,
          network: Networks.find(20), // Networks.solana
          derivationPath: '',
        ),
        Wallet.builder(
          coinType: 19,
          network: Networks.find(19), // Networks.ethereum
          derivationPath: '',
        ),
      ],
    ),
  ];
}
