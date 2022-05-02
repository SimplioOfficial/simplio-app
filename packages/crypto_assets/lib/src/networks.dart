import 'package:crypto_assets/src/coin_types.dart';
import 'package:crypto_assets/src/model/network.dart';

const Network bitcoin = Network(
  url: 'https://btc1.simplio.io/',
  coinType: CoinTypes.TWCoinTypeBitcoin,
  name: 'Bitcoin',
);
const Network solana = Network(
  url: 'https://api.devnet.solana.com/',
  coinType: CoinTypes.TWCoinTypeSolana,
  name: 'Solana',
);
const Network ethereum = Network(
  url: 'https://etcblockexplorer.com/',
  coinType: CoinTypes.TWCoinTypeEthereum,
  name: 'Ethereum',
);
const Network binance = Network(
  url: 'https://bsc-dataseed.binance.org/',
  coinType: CoinTypes.TWCoinTypeBinance,
  name: 'Binance',
);
const Network dash = Network(
  url: 'https://dash1.simplio.io/',
  coinType: CoinTypes.TWCoinTypeDash,
  name: 'Dash',
);
const Network flux = Network(
  url: 'https://explorer.runonflux.io/',
  coinType: CoinTypes.TWCoinTypeZelcash,
  name: 'Flux',
);
const Network dogecoin = Network(
  url: 'https://doge1.simplio.io/',
  coinType: CoinTypes.TWCoinTypeDogecoin,
  name: 'Dogecoin',
);
const Network bitcoinCash = Network(
  url: 'https://bch1.simplio.io/',
  coinType: CoinTypes.TWCoinTypeBitcoinCash,
  name: 'Bitcoin Cash',
);
const Network litecoin = Network(
  url: 'https://ltc1.simplio.io/',
  coinType: CoinTypes.TWCoinTypeLitecoin,
  name: 'Litecoin',
);
const Network zcash = Network(
  url: 'https://zec1.simplio.io/',
  coinType: CoinTypes.TWCoinTypeZcash,
  name: 'Zcash',
);
const Network digibyte = Network(
  url: 'https://dgb1.simplio.io/',
  coinType: CoinTypes.TWCoinTypeDigiByte,
  name: 'Digibyte',
);
