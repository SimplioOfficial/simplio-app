import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/network.dart';

abstract class AssetType {
  final Network network;

  const AssetType({required this.network});
}

class TokenAsset extends AssetType {
  final String contractAddress;

  const TokenAsset({
    required this.contractAddress,
    required Network network,
  }) : super(network: network);
}

class NativeAsset extends AssetType {
  const NativeAsset({
    required Network network,
  }) : super(network: network);
}

class AssetDetail extends Equatable {
  final String name;
  final String ticker;
  final AssetStyle style;

  const AssetDetail({
    required this.name,
    required this.ticker,
    required this.style,
  });

  @override
  List<Object?> get props => [
        name,
        ticker,
      ];
}

class Asset {
  final AssetDetail detail;
  final bool enabled;
  final List<AssetType> assetTypes;

  const Asset({
    required this.detail,
    this.enabled = true,
    required this.assetTypes,
  });

  // /// Asset ID is a unique identifier across application. The morivation
  // /// is to provide a unique value based on a non-unique `name`
  // /// and non-unique `ticker`.
  // String get id {
  //   final String a = detail.name.runes.toList().join('');
  //   final String b = detail.ticker.runes.toList().join('');
  //   final bytes = utf8.encode("$a$b");
  //
  //   return md5.convert(bytes).toString();
  // }
}

class AssetStyle {
  final Color primaryColor;
  final Color foregroundColor;
  final IconData icon;

  const AssetStyle({
    required this.icon,
    required this.primaryColor,
    required this.foregroundColor,
  });
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
