import 'package:flutter/material.dart';

class AuthenticatedSettings extends RouteSettings {
  final TapBarRouteSettings? tapBar;

  @override
  AuthenticatedArguments get arguments => AuthenticatedArguments(
        tapBar: tapBar,
      );

  const AuthenticatedSettings({
    this.tapBar,
  });
}

class AuthenticatedArguments {
  final TapBarRouteSettings? tapBar;

  AuthenticatedArguments({
    this.tapBar,
  });
}

class TapBarRouteSettings {
  final Key selectedKey;
  final bool isVisible;

  TapBarRouteSettings({
    required this.selectedKey,
    this.isVisible = true,
  });
}
