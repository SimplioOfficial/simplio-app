import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/tap_bar_cubit/tap_bar_cubit.dart';
import 'package:simplio_app/view/routes/settings/authenticated_settings.dart';

class TapBarObserver extends NavigatorObserver {
  final BuildContext context;

  TapBarObserver.of(this.context);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _handleArguments(route.settings.arguments);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _handleArguments(newRoute?.settings.arguments);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _handleArguments(previousRoute?.settings.arguments);
  }

  void _handleArguments(Object? args) {
    if (args is AuthenticatedArguments) {
      _setTapBarVisibility(args.tapBar);
    } else {
      _hideTapBar();
    }
  }

  _setTapBarVisibility(TapBarRouteSettings? tapBarSettings) {
    if (tapBarSettings == null) return;

    context.read<TapBarCubit>().setVisibility(
          isVisible: tapBarSettings.isVisible,
          activeItem: tapBarSettings.selectedKey,
        );
  }

  _hideTapBar() {
    context.read<TapBarCubit>().setVisibility();
  }
}
