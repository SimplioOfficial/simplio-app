import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';
import 'package:simplio_app/data/providers/asset_wallet_db_provider.dart';
import 'package:simplio_app/data/providers/trust_wallet_core_provider.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/data/repositories/asset_wallet_repository.dart';
import 'package:simplio_app/data/repositories/auth_repository.dart';
import 'package:simplio_app/data/repositories/wallet_core_repository.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit_listeners.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/logic/wallet_core_bloc/wallet_core_bloc.dart';
import 'package:simplio_app/logic/wallet_core_bloc/wallet_core_bloc_listeners.dart';
import 'package:simplio_app/view/guards/auth_guard.dart';
import 'package:simplio_app/view/guards/initialization_guard.dart';
import 'package:simplio_app/view/routes/authenticated_route.dart';
import 'package:simplio_app/view/routes/unauthenticated_route.dart';
import 'package:simplio_app/view/widgets/loading.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final accountRepository =
      await AccountRepository.builder(db: AccountDbProvider()).init();
  final assetWalletRepository =
      await AssetWalletRepository.builder(db: AssetWalletDbProvider()).init();
  final authRepository =
      await AuthRepository.builder(db: AccountDbProvider()).init();
  final walletCoreRepository =
      WalletCoreRepository.builder(trustWallet: TrustWalletCoreProvider());

  runApp(SimplioApp(
    accountRepository: accountRepository,
    assetWalletRepository: assetWalletRepository,
    authRepository: authRepository,
    walletCoreRepository: walletCoreRepository,
  ));
}

class SimplioApp extends StatefulWidget {
  final AccountRepository accountRepository;
  final AssetWalletRepository assetWalletRepository;
  final AuthRepository authRepository;
  final WalletCoreRepository walletCoreRepository;

  const SimplioApp({
    Key? key,
    required this.accountRepository,
    required this.assetWalletRepository,
    required this.authRepository,
    required this.walletCoreRepository,
  }) : super(key: key);

  @override
  State<SimplioApp> createState() => _SimplioAppState();
}

class _SimplioAppState extends State<SimplioApp> {
  final UnauthenticatedRoute _unauthenticatedRouter = UnauthenticatedRoute();
  final AuthenticatedRoute _authenticatedRouter = AuthenticatedRoute();

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
        RepositoryProvider.value(value: widget.authRepository),
        RepositoryProvider.value(value: widget.walletCoreRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc.builder(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            )..add(GotLastAuthenticated()),
          ),
        ],
        child: MaterialApp(
          title: 'Simplio',
          home: AuthGuard(
            onAuthenticated: (context, state) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => WalletCoreBloc(
                      walletCoreRepository:
                          RepositoryProvider.of<WalletCoreRepository>(context),
                    ),
                  ),
                  BlocProvider(
                    create: (context) =>
                        // account loading needs to be done after bloclistener is initialized
                        AccountCubit.builder(
                      accountRepository:
                          RepositoryProvider.of<AccountRepository>(context),
                      assetWalletRepository:
                          RepositoryProvider.of<AssetWalletRepository>(context),
                    ),
                  ),
                ],
                child: MultiBlocListener(
                  listeners: [
                    AccountCubitListeners().updateWalletCoreAfterSeedImported,
                    WalletCoreBlocListeners()
                        .updateAccountAfterWalletCoreUpdated,
                    AccountCubitListeners().generateSeedAfterAccountCreated,
                  ],
                  child: Builder(
                    builder: (context) {
                      // load logged account - call it here in order to initialize bloc listeners first
                      context.read<AccountCubit>().loadAccount(state.accountId);

                      return InitializationGuard(
                        onInitialized: (BuildContext context) => Navigator(
                          key: AuthenticatedRoute.key,
                          initialRoute: AuthenticatedRoute.home,
                          onGenerateRoute: _authenticatedRouter.generateRoute,
                        ),
                        onLoading: (BuildContext context) => const Loading(),
                      );
                    },
                  ),
                ),
              );
            },
            onUnauthenticated: (context) => Navigator(
              key: UnauthenticatedRoute.key,
              initialRoute: UnauthenticatedRoute.login,
              onGenerateRoute: _unauthenticatedRouter.generateRoute,
            ),
          ),
        ),
      ),
    );
  }
}
