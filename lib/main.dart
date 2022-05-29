import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';
import 'package:simplio_app/data/providers/asset_wallet_db_provider.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/data/repositories/asset_wallet_repository.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';
import 'package:simplio_app/view/routes/app_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final accountRepository =
      await AccountRepository.builder(db: AccountDbProvider()).init();
  final assetWalletRepository =
      await AssetWalletRepository.builder(db: AssetWalletDbProvider()).init();

  runApp(SimplioApp(
    accountRepository: accountRepository,
    assetWalletRepository: assetWalletRepository,
  ));
}

class SimplioApp extends StatefulWidget {
  final AccountRepository accountRepository;
  final AssetWalletRepository assetWalletRepository;

  const SimplioApp({
    Key? key,
    required this.accountRepository,
    required this.assetWalletRepository,
  }) : super(key: key);

  @override
  State<SimplioApp> createState() => _SimplioAppState();
}

class _SimplioAppState extends State<SimplioApp> {
  final AppRoute _router = AppRoute();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.accountRepository),
        RepositoryProvider.value(value: widget.assetWalletRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AccountBloc(
              accountRepository:
                  RepositoryProvider.of<AccountRepository>(context),
            )..add(AccountLastRequested()),
          ),
        ],
        child: MaterialApp(
          title: 'Simplio',
          initialRoute: AppRoute.home,
          onGenerateRoute: _router.generateRoute,
        ),
      ),
    );
  }
}
