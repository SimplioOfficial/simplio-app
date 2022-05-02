import 'package:flutter/material.dart';

class RouteUtils {
  static RouteFactory onGenerateSubRoute(
      {required RouteFactory onGenerateRoute,
      required RouteSettings settings,
      required String subRoute,
      baseRoute = ''}) {
    String? subRoute;
    if (settings.name!.startsWith(baseRoute)) {
      subRoute = settings.name?.substring(baseRoute.length);
    } else {
      subRoute = settings.name;
    }

    final route = subRoute!.isNotEmpty ? subRoute : '/';
    final routeSettings = settings.copyWith(name: route);

    // RouteSettings(
    //   name: route,
    //   arguments: settings.arguments,
    // );

    return (_) => onGenerateRoute(routeSettings);
  }

  static String getSubroute(RouteSettings settings, String baseRoute) {
    String? subRoute;
    if (settings.name!.startsWith(baseRoute)) {
      subRoute = settings.name?.substring(baseRoute.length);
    } else {
      subRoute = settings.name;
    }

    return subRoute!.isNotEmpty ? subRoute : '/';
  }

  static String getParentRoute(String route) {
    print(route.split('/'));
    if (route.startsWith('/')) {
      return '/' + route.split('/')[1];
    } else {
      return '/' + route.split('/').first;
    }
  }
}
