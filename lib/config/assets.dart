import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset.dart';

class Assets {
  const Assets._();

  static const Asset simplio = Asset(
    name: 'Simplio',
    ticker: 'sio',
    primaryColor: Colors.blue,
    foregroundColor: Colors.white,
    icon: Icons.wb_sunny_outlined,
    networks: [solana],
  );

  static const Asset bitcoin = Asset(
    name: 'Bitcoin',
    ticker: 'btc',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Colors.orange,
    foregroundColor: Colors.black,
  );

  static const Asset bitcoinCach = Asset(
    name: 'Bitcoin Cash',
    ticker: 'bch',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Colors.green,
    foregroundColor: Colors.white,
  );

  static const Asset solana = Asset(
    name: 'Solana',
    ticker: 'sol',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Colors.purple,
    foregroundColor: Colors.white,
  );

  static const Asset flux = Asset(
    name: 'Flux',
    ticker: 'flux',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Colors.blue,
    foregroundColor: Colors.white,
  );

  static const Asset dogecoin = Asset(
    name: 'Dogecoin',
    ticker: 'doge',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Colors.yellow,
    foregroundColor: Colors.black,
  );

  static const Asset dash = Asset(
    name: 'Dash',
    ticker: 'dash',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Colors.blue,
    foregroundColor: Colors.white,
  );

  static const Asset digibyte = Asset(
    name: 'Digibyte',
    ticker: 'dgb',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Colors.blue,
    foregroundColor: Colors.white,
  );

  static const Asset litecoin = Asset(
    name: 'Litecoin',
    ticker: 'ltc',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Color(0xFFE2E2E2),
    foregroundColor: Colors.black,
  );

  static const Asset zcash = Asset(
    name: 'Zcash',
    ticker: 'zec',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Color(0xFFF8D434),
    foregroundColor: Colors.white,
  );

  static const List<Asset> supported = [
    simplio,
    solana,
    bitcoin,
    bitcoinCach,
    flux,
    dogecoin,
    dash,
    digibyte,
    litecoin,
    zcash,
  ];
}