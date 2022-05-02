import 'package:crypto_assets/src/model/network.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

const Network bitcoin = Network(
  url: 'https://btc1.simplio.io/',
  coinType: TWCoinType.TWCoinTypeBitcoin,
);
const Network solana = Network(
  url: 'https://api.devnet.solana.com/',
  coinType: TWCoinType.TWCoinTypeSolana,
);
const Network ethereum = Network(
  url: 'https://bsc-dataseed.binance.org/',
  coinType: TWCoinType.TWCoinTypeEthereum,
);
const Network binance = Network(
  url: 'https://bsc-dataseed.binance.org/',
  coinType: TWCoinType.TWCoinTypeBinance,
);
const Network dash = Network(
  url: 'https://dash1.simplio.io/',
  coinType: TWCoinType.TWCoinTypeDash,
);
const Network flux = Network(
  url: 'https://explorer.runonflux.io/',
  coinType: TWCoinType.TWCoinTypeZcash,
);
const Network dogecoin = Network(
  url: 'https://doge1.simplio.io/',
  coinType: TWCoinType.TWCoinTypeDogecoin,
);
const Network bitcoinCash = Network(
  url: 'https://bch1.simplio.io/',
  coinType: TWCoinType.TWCoinTypeBitcoinCash,
);
const Network litecoin = Network(
  url: 'https://ltc1.simplio.io/',
  coinType: TWCoinType.TWCoinTypeLitecoin,
);
const Network zcash = Network(
  url: 'https://zec1.simplio.io/',
  coinType: TWCoinType.TWCoinTypeZcash,
);
const Network digibyte = Network(
  url: 'https://dgb1.simplio.io/',
  coinType: TWCoinType.TWCoinTypeDigiByte,
);
