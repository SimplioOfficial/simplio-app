import 'package:flutter/material.dart';
import 'package:simplio_app/view/screens/initial/generate_seed_screen.dart';
import 'package:simplio_app/view/screens/initial/manual_seed_import_screen.dart';

class HomeInitialRoute {
  static const String initial = '/';
  static const String generateSeed = '/generate-seed';
  static const String manualSeedImport = '/manual-seed-import';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
      case generateSeed:
        return MaterialPageRoute(
          builder: (context) => const GenerateSeedScreen(),
        );
      case manualSeedImport:
        return MaterialPageRoute(
          builder: (context) => const ManualSeedImportScreen(),
        );
      default:
        throw const FormatException('Screen not found');
    }
  }
}
