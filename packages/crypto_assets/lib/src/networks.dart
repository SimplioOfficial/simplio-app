import 'package:crypto_assets/src/coin_types.dart';
import 'package:crypto_assets/src/model/network.dart';

const Network bitcoin = Network(
  url: 'https://btc1.trezor.io/',
  coinType: CoinTypes.TWCoinTypeBitcoin,
  name: 'Bitcoin',
);
const Network solana = Network(
  url: 'https://api.mainnet-beta.solana.com/',
  coinType: CoinTypes.TWCoinTypeSolana,
  name: 'Solana',
);
const Network ethereum = Network(
  url: 'https://ethblockexplorer.org/',
  coinType: CoinTypes.TWCoinTypeEthereum,
  name: 'Ethereum',
);
const Network binance = Network(
  url: 'https://bscxplorer.com/',
  coinType: CoinTypes.TWCoinTypeSmartChain,
  name: 'Binance',
);
const Network dash = Network(
  url: 'https://dash1.trezor.io/',
  coinType: CoinTypes.TWCoinTypeDash,
  name: 'Dash',
);
const Network flux = Network(
  url: 'https://explorer.runonflux.io/',
  coinType: CoinTypes.TWCoinTypeZelcash,
  name: 'Flux',
);
const Network dogecoin = Network(
  url: 'https://doge1.trezor.io/',
  coinType: CoinTypes.TWCoinTypeDogecoin,
  name: 'Dogecoin',
);
const Network bitcoinCash = Network(
  url: 'https://bch1.trezor.io/',
  coinType: CoinTypes.TWCoinTypeBitcoinCash,
  name: 'Bitcoin Cash',
);
const Network litecoin = Network(
  url: 'https://ltc1.trezor.io/',
  coinType: CoinTypes.TWCoinTypeLitecoin,
  name: 'Litecoin',
);
const Network zcash = Network(
  url: 'https://zec1.trezor.io/',
  coinType: CoinTypes.TWCoinTypeZcash,
  name: 'Zcash',
);
const Network digibyte = Network(
  url: 'https://dgb1.trezor.io/',
  coinType: CoinTypes.TWCoinTypeDigiByte,
  name: 'Digibyte',
);
const Network cosmos = Network(
  url: 'https://api.cosmos.network/',
  coinType: CoinTypes.TWCoinTypeCosmos,
  name: 'Cosmos',
);
const Network osmosis = Network(
  url: 'https://lcd-osmosis.keplr.app/',
  transactionUrl: 'https://api-osmosis-chain.imperator.co/',
  coinType: CoinTypes.TWCoinTypeOsmosis,
  name: 'Osmosis',
);
