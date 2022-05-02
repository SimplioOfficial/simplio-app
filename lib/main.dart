import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';
import 'package:simplio_app/data/providers/asset_wallet_db_provider.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/data/repositories/asset_wallet_repository.dart';
import 'package:simplio_app/data/repositories/trust_wallet_repository.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';
import 'package:simplio_app/logic/trust_wallet_core_bloc/trust_wallet_core_bloc.dart';
import 'package:simplio_app/view/routes/app_route.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final accountRepository =
      await AccountRepository.builder(db: AccountDbProvider()).init();
  final assetWalletRepository =
      await AssetWalletRepository.builder(db: AssetWalletDbProvider()).init();
  final trustWalletRepository = TrustWalletRepository();

  runApp(SimplioApp(
    accountRepository: accountRepository,
    assetWalletRepository: assetWalletRepository,
    trustWalletRepository: trustWalletRepository,
  ));
}

class SimplioApp extends StatefulWidget {
  final AccountRepository accountRepository;
  final AssetWalletRepository assetWalletRepository;
  final TrustWalletRepository trustWalletRepository;

  const SimplioApp({
    Key? key,
    required this.accountRepository,
    required this.assetWalletRepository,
    required this.trustWalletRepository,
  }) : super(key: key);

  @override
  State<SimplioApp> createState() => _SimplioAppState();
}

class _SimplioAppState extends State<SimplioApp> {
  final AppRoute _router = AppRoute();

  @override
  void initState() {
    TrustWalletCoreLib.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.accountRepository),
        RepositoryProvider.value(value: widget.assetWalletRepository),
        RepositoryProvider.value(value: widget.trustWalletRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AccountBloc(
              accountRepository:
                  RepositoryProvider.of<AccountRepository>(context),
            )..add(AccountLastRequested()),
          ),
          BlocProvider(
            create: (context) => TrustWalletCoreBloc(
              trustWalletRepository:
                  RepositoryProvider.of<TrustWalletRepository>(context),
            ),
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
