import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset.dart';

class AssetDetails {
  AssetDetails._();

  static const AssetDetail simplio = AssetDetail(
    name: 'Simplio',
    ticker: 'SIO',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail bitcoin = AssetDetail(
    name: 'Bitcoin',
    ticker: 'BTC',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xffff9900),
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail solana = AssetDetail(
    name: 'Solana',
    ticker: 'SOL',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xff411e7d),
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail ethereum = AssetDetail(
    name: 'Ethereum',
    ticker: 'ETH',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail chainlink = AssetDetail(
    name: 'Chainlink',
    ticker: 'CHAIN',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Colors.black12,
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail bitcoinCash = AssetDetail(
    name: 'Bitcoin Cash',
    ticker: 'BCH',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xff8dc351),
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail flux = AssetDetail(
    name: 'Flux',
    ticker: 'FLUX',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xff2a60d0),
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail dogecoin = AssetDetail(
    name: 'Dogecoin',
    ticker: 'DOGE',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xffffe4a4),
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail dash = AssetDetail(
    name: 'Dash',
    ticker: 'DASH',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xff008be6),
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail digibyte = AssetDetail(
    name: 'Digibyte',
    ticker: 'DGB',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xff006ad2),
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail litecoin = AssetDetail(
    name: 'Litecoin',
    ticker: 'LTC',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xffeaeaea),
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail binanceUSD = AssetDetail(
    name: 'Binance USD',
    ticker: 'BUSD',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xfff3ba2f),
      foregroundColor: Colors.white,
    ),
  );

  static const AssetDetail zcash = AssetDetail(
    name: 'Zcash',
    ticker: 'ZEC',
    style: AssetStyle(
      icon: Icons.wb_sunny_outlined,
      primaryColor: Color(0xfff5df97),
      foregroundColor: Colors.white,
    ),
  );
}
