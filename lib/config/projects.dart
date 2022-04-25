import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/wallet_project.dart';

class Projects {
  static const WalletProject simplio = WalletProject(
    name: 'Simplio',
    ticker: 'sio',
    primaryColor: Colors.blue,
    foregroundColor: Colors.white,
    icon: Icons.wb_sunny_outlined,
    networks: [solana],
  );

  static const WalletProject bitcoin = WalletProject(
    name: 'Bitcoin',
    ticker: 'btc',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Colors.orange,
    foregroundColor: Colors.black,
  );

  static const WalletProject solana = WalletProject(
    name: 'Solana',
    ticker: 'sol',
    icon: Icons.wb_sunny_outlined,
    primaryColor: Colors.purple,
    foregroundColor: Colors.white,
  );

  static const List<WalletProject> supported = [
    solana,
    simplio,
    bitcoin,
  ];
}