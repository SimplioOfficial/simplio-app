import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Asset extends Equatable {
  final String name;
  final String ticker;
  final Color primaryColor;
  final Color foregroundColor;
  final IconData icon;
  final List<Asset>? networks;

  const Asset({
    required this.name,
    required this.ticker,
    required this.primaryColor,
    required this.foregroundColor,
    required this.icon,
    this.networks,
  });

  @override
  List<Object?> get props => [name, ticker, primaryColor, networks];
}