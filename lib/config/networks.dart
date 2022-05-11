import 'package:simplio_app/data/model/network.dart';

class Networks {
  Networks._();

  static const Network bitcoin = Network(url: '');
  static const Network solana = Network(url: '');
  static const Network ethereum = Network(url: '');
  static const Network binance = Network(url: '');
  static const Network dash = Network(url: '');
  static const Network flux = Network(url: '');
  static const Network dogecoin = Network(url: '');
  static const Network bitcoinCash = Network(url: '');
  static const Network litecoin = Network(url: '');
  static const Network zcash = Network(url: '');
  static const Network digibyte = Network(url: '');

  static Network find(int coinType) {
    switch (coinType) {
      case 0:
        return Networks.bitcoin;
      case 1:
        return Networks.solana;
      case 2:
        return Networks.ethereum;
      case 3:
        return Networks.binance;
      case 4:
        return Networks.dash;
      case 5:
        return Networks.flux;
      case 6:
        return Networks.dogecoin;
      case 7:
        return Networks.bitcoinCash;
      case 8:
        return Networks.litecoin;
      case 9:
        return Networks.zcash;
      case 10:
        return Networks.digibyte;

      default:
        return const Network(url: '');
    }
  }
}
