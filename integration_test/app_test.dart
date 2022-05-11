import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:simplio_app/main.dart';
import 'package:simplio_app/view/widgets/appbar_search.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  //TICKERs
  const sioTicker = 'sio';
  const solTicker = 'sol';
  const btcTicker = 'btc';

  //KEYs
  const switchKey = 'switch_widget_';

  //TEXTs
  const noWalletText = 'You have no wallet';
  const listWallets = 'Wallets';
  const listAssets = 'Get your favorites.';
  const enableAssets = 'Enable assets to add them to your portfolio.';

  //BUTTONs
  final sioButton = find.byKey(const ValueKey(switchKey + sioTicker));
  final solButton = find.byKey(const ValueKey(switchKey + solTicker));
  final btcButton = find.byKey(const ValueKey(switchKey + btcTicker));
  group('Testing App Performance Tests', () {
    testWidgets('Scrolling test', (tester) async {
      tester.printToConsole(DateTime.now().toString() + ' ' + 'Starting tests');
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SimplioApp());

      //Checking first page
      tester.printToConsole('Checking first page');
      expect(find.text(noWalletText), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      final listFinder = find.byType(CustomScrollView);

      await binding.watchPerformance(() async {
        await tester.fling(listFinder, const Offset(0, -500), 10000);
        await tester.pumpAndSettle();

        await tester.fling(listFinder, const Offset(0, 500), 10000);
        await tester.pumpAndSettle();
      }, reportKey: 'scrolling_summary');
    });

    testWidgets('Add Wallet and search', (tester) async {
      //Initialization an app
      tester.printToConsole(DateTime.now().toString() + ' ' + 'Starting tests');
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SimplioApp());

      //Checking first page
      expect(find.text(noWalletText), findsOneWidget);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      //Add, back and verify
      expect(find.text(listAssets), findsOneWidget);
      expect(find.text(enableAssets), findsOneWidget);
      await tester.tap(sioButton);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.text(listWallets), findsOneWidget);
      expect(find.text(sioTicker.toUpperCase()), findsWidgets);
      await tester.pumpAndSettle();

      //add a another wallet
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(solButton);
      await tester.pumpAndSettle();

      //click on search and verify
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();
      final switchSol = tester.widget<Switch>(solButton);
      expect(switchSol.value, true);
      await tester.pumpAndSettle();

      //search and verify
      await tester.enterText(find.byType(TextField), btcTicker);
      await tester.pumpAndSettle();
      await tester.tap(btcButton);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconButton)); //close search
      final switchBtc = tester.widget<Switch>(btcButton);
      expect(switchBtc.value, true);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.text(sioTicker.toUpperCase()), findsWidgets);
      expect(find.text(solTicker.toUpperCase()), findsWidgets);
      expect(find.text(btcTicker.toUpperCase()), findsWidgets);
      await tester.pumpAndSettle();
      tester.printToConsole(DateTime.now().toString() + ' ' + 'Tests ended');
    });
  });
}
