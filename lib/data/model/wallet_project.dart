import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class WalletProject extends Equatable {
  final String name;
  final String ticker;
  final Color primaryColor;
  final List<WalletProject>? networks;

  const WalletProject(
      {required this.name,
      required this.ticker,
      required this.primaryColor,
      this.networks});

  @override
  List<Object?> get props => [name, ticker, primaryColor, networks];
}