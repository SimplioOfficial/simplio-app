import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/wallet_project.dart';

class Projects {
  static const WalletProject simplio = WalletProject(
      name: 'Simplio',
      ticker: 'sio',
      primaryColor: Colors.blue,
      networks: [solana]);

  static const WalletProject bitcoin = WalletProject(
      name: 'Bitcoin', ticker: 'btc', primaryColor: Colors.orange);

  static const WalletProject solana =
      WalletProject(name: 'Solana', ticker: 'sol', primaryColor: Colors.purple);

  final List<WalletProject> _supportedProjects = [
    solana,
    simplio,
    bitcoin,
  ];

  List<WalletProject> get supported => _supportedProjects;
}