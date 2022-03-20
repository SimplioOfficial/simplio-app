import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/wallet_project.dart';

// Projects contains all supported crypto projects in simplio app.
// You can access the entire list of supported projects by calling
// `supported` getter of a `Projects` instance.
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