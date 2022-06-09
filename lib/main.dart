import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';
import 'package:simplio_app/data/providers/asset_wallet_db_provider.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/data/repositories/asset_wallet_repository.dart';
import 'package:simplio_app/data/repositories/auth_repository.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/view/guards/auth_guard.dart';
import 'package:simplio_app/view/routes/authenticated_route.dart';
import 'package:simplio_app/view/routes/unauthenticated_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final accountRepository =
      await AccountRepository.builder(db: AccountDbProvider()).init();
  final assetWalletRepository =
      await AssetWalletRepository.builder(db: AssetWalletDbProvider()).init();
  final authRepository =
      await AuthRepository.builder(db: AccountDbProvider()).init();

  runApp(SimplioApp(
    accountRepository: accountRepository,
    assetWalletRepository: assetWalletRepository,
    authRepository: authRepository,
  ));
}

class SimplioApp extends StatefulWidget {
  final AccountRepository accountRepository;
  final AssetWalletRepository assetWalletRepository;
  final AuthRepository authRepository;

  const SimplioApp({
    Key? key,
    required this.accountRepository,
    required this.assetWalletRepository,
    required this.authRepository,
  }) : super(key: key);

  @override
  State<SimplioApp> createState() => _SimplioAppState();
}

class _SimplioAppState extends State<SimplioApp> {
  final UnauthenticatedRoute _unauthenticatedRouter = UnauthenticatedRoute();
  final AuthenticatedRoute _authenticatedRouter = AuthenticatedRoute();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.accountRepository),
        RepositoryProvider.value(value: widget.assetWalletRepository),
        RepositoryProvider.value(value: widget.authRepository),
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
                    create: (context) => AccountCubit.builder(
                      accountRepository:
                          RepositoryProvider.of<AccountRepository>(context),
                      assetWalletRepository:
                          RepositoryProvider.of<AssetWalletRepository>(context),
                    )..loadAccount(state.accountId),
                  ),
                ],
                child: Navigator(
                  key: AuthenticatedRoute.key,
                  initialRoute: AuthenticatedRoute.home,
                  onGenerateRoute: _authenticatedRouter.generateRoute,
                ),
              );
            },
            onUnauthenticated: (context) => Navigator(
              key: UnauthenticatedRoute.key,
              initialRoute: UnauthenticatedRoute.home,
              onGenerateRoute: _unauthenticatedRouter.generateRoute,
            ),
          ),
        ),
      ),
    );
  }
}
