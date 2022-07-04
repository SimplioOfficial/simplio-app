import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simplio_app/data/model/account_settings.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';
import 'package:simplio_app/data/providers/asset_wallet_db_provider.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/data/repositories/asset_wallet_repository.dart';
import 'package:simplio_app/data/repositories/auth_repository.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/view/routes/authenticated_route.dart';
import 'package:simplio_app/view/routes/guards/auth_guard.dart';
import 'package:simplio_app/view/routes/unauthenticated_route.dart';
import 'package:simplio_app/view/screens/authenticated_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    super.key,
    required this.accountRepository,
    required this.assetWalletRepository,
    required this.authRepository,
  });

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
          BlocProvider(
            create: (context) => AccountCubit.builder(
              accountRepository:
                  RepositoryProvider.of<AccountRepository>(context),
              assetWalletRepository:
                  RepositoryProvider.of<AssetWalletRepository>(context),
            ),
          ),
        ],
        child: BlocBuilder<AccountCubit, AccountState>(
          buildWhen: (previous, current) =>
              previous.account?.settings.locale.languageCode != null &&
              previous.account?.settings.locale.languageCode !=
                  current.account?.settings.locale.languageCode,
          builder: (context, state) => MaterialApp(
            onGenerateTitle: (context) => context.locale.simplioTitle,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.account?.settings.locale ??
                const AccountSettings.preset().locale,
            theme: ThemeData(
              backgroundColor: Colors.white,
              scaffoldBackgroundColor: Colors.white,
              unselectedWidgetColor: Colors.black38,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                unselectedItemColor: Colors.black38,
                selectedItemColor: Colors.blue,
                selectedLabelStyle: TextStyle(
                  color: Colors.red,
                ),
                backgroundColor: Color.fromRGBO(255, 255, 255, 0.96),
              ),
              appBarTheme: const AppBarTheme(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                elevation: 0.3,
              ),
            ),
            home: AuthGuard(
              onAuthenticated: (context, state) {
                return Builder(
                  builder: (context) {
                    context.read<AccountCubit>().loadAccount(state.accountId);

                    return AuthenticatedScreen(
                      navigatorKey: AuthenticatedRoute.key,
                      initialRoute: AuthenticatedRoute.home,
                      onGenerateRoute: _authenticatedRouter.generateRoute,
                    );
                  },
                );
              },
              onUnauthenticated: (context) {
                context.read<AccountCubit>().clearAccount();

                return Navigator(
                  key: UnauthenticatedRoute.key,
                  initialRoute: UnauthenticatedRoute.home,
                  onGenerateRoute: _unauthenticatedRouter.generateRoute,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
