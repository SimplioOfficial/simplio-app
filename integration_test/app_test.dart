import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:simplio_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //TICKERs
  const sioTicker = 'sio';
  const btcTicker = 'btc';
  const solTicker = 'sol';

  //KEYs
  const seedInput = 'seed_input';
  const switchKey = 'switch_widget_';
  const walletListNameKey = 'wallet-list-item-project-name_';
  const keyButtonNextKey = 'seed_import_button';
  const importRecoverySeedKey = 'manual_seed_import';
  const showGeneratedSeedKey = 'manual_seed_import_button';


  //TOOLTIPs
  const backButtonTolltip = 'Back';

  //TEXTs
  const importRecoverySeed = 'Import recovery seed';
  const noWalletText = 'You have no wallet';
  const generatedSeedText = 'Generated seed';
  const coinNameSolanaText = 'Solana';
  const coinNameBitcoinText = 'Bitcoin';
  const coinNameSimplioText = 'Simplio';
  const seedText = 'quit audit measure club mesh design execute side idea very step effort sight system pause stick reopen easy jeans segment side soap cactus attack';

  group('Testing App Performance Tests', () {
    testWidgets('Simplio App tests', (tester) async {
      //Initialization an app
      tester.printToConsole('Starting tests');
      print(DateTime.now());
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SimplioApp());
      //Checking first page
      expect(find.text(generatedSeedText), findsOneWidget);
      expect(find.text(importRecoverySeed), findsOneWidget);
      //Going to import seed page and check
      await tester.tap(find.byKey(const ValueKey(importRecoverySeedKey)));
      await tester.pumpAndSettle();
      expect(find.byKey(const ValueKey(seedInput)), findsOneWidget);
      await tester.enterText(find.byKey(const ValueKey(seedInput)), 'test');
      await tester.pumpAndSettle();
      expect(find.text('Invalid seed'), findsOneWidget);
      await tester.enterText(find.byKey(const ValueKey(seedInput)), '');
      await tester.pumpAndSettle();
      expect(find.text('Invalid seed'), findsNothing);
      await tester.enterText(find.byKey(const ValueKey(seedInput)), seedText);
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey(showGeneratedSeedKey)));
      await tester.pumpAndSettle();
      expect(find.text(generatedSeedText), findsOneWidget);
      expect(find.text(importRecoverySeed), findsOneWidget);
      //Going wallets page and check
      await tester.tap(find.byKey(const ValueKey(keyButtonNextKey)));
      await tester.pumpAndSettle();
      expect(find.text(noWalletText), findsOneWidget);
      await tester.pumpAndSettle();
      //Adding wallets check
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      final sioButton = find.byKey(const ValueKey(switchKey + sioTicker));
      final solButton = find.byKey(const ValueKey(switchKey + solTicker));
      final btcButton = find.byKey(const ValueKey(switchKey + btcTicker));
      expect(sioButton, findsWidgets);
      expect(solButton, findsWidgets);
      expect(btcButton, findsWidgets);
      await tester.pumpAndSettle();
      await tester.tap(sioButton);
      await tester.pumpAndSettle();
      await tester.tap(solButton);
      await tester.pumpAndSettle();
      await tester.tap(btcButton);
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(backButtonTolltip));
      await tester.pumpAndSettle();
      //Wallets list check
      expect(find.text(noWalletText), findsNothing);
      expect(find.text(coinNameSolanaText), findsWidgets);
      expect(find.text(coinNameSimplioText), findsWidgets);
      expect(find.text(coinNameBitcoinText), findsWidgets);
      //Checking each wallet - simplio
      await tester.tap(find.byKey(const ValueKey(walletListNameKey + sioTicker)));
      await tester.pumpAndSettle();
      expect(find.text(coinNameSimplioText), findsWidgets);
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(backButtonTolltip));
      await tester.pumpAndSettle();
      //Checking each wallet - bitcoin
      await tester.tap(find.byKey(const ValueKey(walletListNameKey + btcTicker)));
      await tester.pumpAndSettle();
      expect(find.text(coinNameBitcoinText), findsWidgets);
      await tester.tap(find.byTooltip(backButtonTolltip));
      await tester.pumpAndSettle();
      //Checking each wallet - solna
      await tester.tap(find.byKey(const ValueKey(walletListNameKey + solTicker)));
      await tester.pumpAndSettle();
      expect(find.text(coinNameSolanaText), findsWidgets);
      await tester.tap(find.byTooltip(backButtonTolltip));
      await tester.pumpAndSettle();
     });
  });
}
