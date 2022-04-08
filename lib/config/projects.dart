import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/wallet_project.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

class Projects {
  static const WalletProject simplio = WalletProject(
    name: 'Simplio',
    ticker: 'sio',
    primaryColor: Colors.blue,
    foregroundColor: Colors.white,
    icon: Icons.wb_sunny_outlined,
    // change this in future
    coinType: TWCoinType.TWCoinTypeSolana,
    networks: [solana],
  );

  static const WalletProject bitcoin = WalletProject(
    name: 'Bitcoin',
    ticker: 'btc',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Colors.orange,
    foregroundColor: Colors.black,
    coinType: TWCoinType.TWCoinTypeBitcoin,
  );

  static const WalletProject solana = WalletProject(
    name: 'Solana',
    ticker: 'sol',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Colors.purple,
    foregroundColor: Colors.white,
    coinType: TWCoinType.TWCoinTypeSolana,
  );

  static const List<WalletProject> supported = [
    solana,
    simplio,
    bitcoin,
  ];
}
