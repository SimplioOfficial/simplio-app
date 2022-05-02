import 'package:flutter/material.dart';
import 'package:simplio_app/data/model/asset_wallet.dart';
import 'package:simplio_app/view/screens/assets_screen.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';
import 'package:simplio_app/view/screens/not_found_screen.dart';
import 'package:simplio_app/view/screens/seed_backup_screen.dart';
import 'package:simplio_app/view/screens/seed_import_screen.dart';
import 'package:simplio_app/view/screens/wallet_detail_screen.dart';
import 'package:simplio_app/view/screens/wallet_receive_screen.dart';
import 'package:simplio_app/view/screens/wallet_send_screen.dart';

class AuthenticatedRoute {
  static final key = GlobalKey<NavigatorState>(
    debugLabel: 'authenticated_route',
  );

  static const String home = '/';
  static const String assets = '/assets';
  static const String wallet = '/wallet';
  static const String walletSend = '/wallet/send';
  static const String walletReceive = '/wallet/receive';
  static const String seedBackup = '/seed-backup';
  static const String seedImport = '/seed-import';

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      case wallet:
        return MaterialPageRoute(
            builder: (_) => WalletDetailScreen(
                  assetWallet: settings.arguments! as AssetWallet,
                ));
      case walletSend:
        return MaterialPageRoute(
            builder: (_) => WalletSendScreen(
                  assetWallet: settings.arguments! as AssetWallet,
                ));
      case walletReceive:
        return MaterialPageRoute(
            builder: (_) => WalletReceiveScreen(
                  assetWallet: settings.arguments! as AssetWallet,
                ));
      case assets:
        return MaterialPageRoute(
          builder: (_) => const AssetsScreen(),
        );
      case seedBackup:
        return MaterialPageRoute(
          builder: (_) => const SeedBackupScreen(),
        );
      case seedImport:
        return MaterialPageRoute(
          builder: (_) => const SeedImportScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => NotFoundScreen(page: settings.name),
        );
    }
  }
}
