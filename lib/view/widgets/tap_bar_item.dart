import 'package:flutter/material.dart';

enum TapTabItemType {
  button,
  spacer,
}

typedef TapBarItemCallback = void Function(BuildContext context, Key key);

class TapBarItem {
  final Key? key;
  final TapTabItemType tapBarItemType;
  final TapBarItemCallback? onTap;
  final IconData? icon;
  final IconData? activeIcon;
  final String? label;

  TapBarItem({
    required this.tapBarItemType,
    this.key,
    this.onTap,
    this.icon,
    this.activeIcon,
    this.label,
  }) : assert(
          tapBarItemType == TapTabItemType.button ? key != null : true,
          "Key must be provided for TapBarItem of type $tapBarItemType",
        );
}
