import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Asset extends Equatable {
  final String name;
  final String ticker;
  final AssetStyle style;
  final List<Asset>? networks;

  const Asset({
    required this.name,
    required this.ticker,
    required this.style,
    this.networks,
  });

  @override
  List<Object?> get props => [
        name,
        ticker,
        style,
        networks,
      ];
}

class AssetStyle extends Equatable {
  final Color primaryColor;
  final Color foregroundColor;
  final IconData icon;

  const AssetStyle({
    required this.icon,
    required this.primaryColor,
    required this.foregroundColor,
  });

  @override
  List<Object> get props => [
        primaryColor,
        foregroundColor,
        icon,
      ];
}

class AssetToggle extends Equatable {
  final bool toggled;
  final Asset asset;

  const AssetToggle({
    this.toggled = false,
    required this.asset,
  });

  @override
  List<Object> get props => [
        toggled,
        asset,
      ];
}
