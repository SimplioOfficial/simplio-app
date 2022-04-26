import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:simplio_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const switchKey = 'switch_widget_';
  const sioTicker = 'sio';
  const btcTicker = 'btc';
  const solTicker = 'sol';
  const walletListName = 'wallet-list-item-project-name_';
  const keyButtonNext = 'seed_import_button';
  const backButtonTolltip = 'Back';
  const noWalletText = 'You have no wallet';
  const coinNameSolana = 'Solana';
  const coinNameBitcoin = 'Bitcoin';
  const coinNameSimplio = 'Simplio';

  group('Testing App Performance Tests', () {
    testWidgets('add wallet', (tester) async {
      await tester.pumpAndSettle();
      await tester.pumpWidget(const SimplioApp());
      await tester.tap(find.byKey(const ValueKey(keyButtonNext)));
      await tester.pumpAndSettle();
      expect(find.text(noWalletText), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));

      await tester.pumpAndSettle();
      final sioButton = find.byKey(const ValueKey(switchKey + sioTicker));
      final solButton = find.byKey(const ValueKey(switchKey + solTicker));
      final btcButton = find.byKey(const ValueKey(switchKey + btcTicker));

      expect(sioButton, findsWidgets);
      expect(solButton, findsWidgets);
      expect(btcButton, findsWidgets);
      await tester.pumpAndSettle();
      //error for tap switch
      await tester.tap(sioButton);
      await tester.pumpAndSettle();
      await tester.tap(solButton);
      await tester.pumpAndSettle();
      await tester.tap(btcButton);
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(backButtonTolltip));
      await tester.pumpAndSettle();

      expect(find.text(noWalletText), findsNothing);
      expect(find.text(coinNameSolana), findsWidgets);
      expect(find.text(coinNameSimplio), findsWidgets);
      expect(find.text(coinNameBitcoin), findsWidgets);
      
      await tester.tap(find.byKey(const ValueKey(walletListName + sioTicker)));
      await tester.pumpAndSettle();
      expect(find.text(coinNameSimplio), findsWidgets);
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip(backButtonTolltip));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey(walletListName + btcTicker)));
      await tester.pumpAndSettle();
      expect(find.text(coinNameBitcoin), findsWidgets);
      await tester.tap(find.byTooltip(backButtonTolltip));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const ValueKey(walletListName + solTicker)));
      await tester.pumpAndSettle();
      expect(find.text(coinNameSolana), findsWidgets);
      await tester.tap(find.byTooltip(backButtonTolltip));
      await tester.pumpAndSettle();
     });
  });
}
