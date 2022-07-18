import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simplio_app/data/http_clients/secured_http_client.dart';
import 'package:simplio_app/data/model/account_settings.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';
import 'package:simplio_app/data/providers/asset_wallet_db_provider.dart';
import 'package:simplio_app/data/providers/auth_token_db_provider.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/data/repositories/asset_wallet_repository.dart';
import 'package:simplio_app/data/repositories/auth_repository.dart';
import 'package:simplio_app/data/services/password_change_service.dart';
import 'package:simplio_app/data/services/password_reset_service.dart';
import 'package:simplio_app/data/services/refresh_token_service.dart';
import 'package:simplio_app/data/services/sign_in_service.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/data/services/sign_up_service.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/view/routes/authenticated_route.dart';
import 'package:simplio_app/view/routes/guards/auth_guard.dart';
import 'package:simplio_app/view/routes/unauthenticated_route.dart';
import 'package:simplio_app/view/screens/authenticated_screen.dart';
import 'package:simplio_app/view/screens/splash_screen.dart';
import 'package:simplio_app/view/themes/dark_mode.dart';
import 'package:simplio_app/view/themes/light_mode.dart';

import 'data/http_clients/public_http_client.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  /// Initialize all top-level Hive Db Providers
  final accountDbProvider = AccountDbProvider();
  final assetWalletDbProvider = AssetWalletDbProvider();
  final authTokenDbProvider = AuthTokenDbProvider();

  await accountDbProvider.init();
  await assetWalletDbProvider.init();
  await authTokenDbProvider.init();

  /// Init http client
  const apiUrl = String.fromEnvironment('API_URL');
  final publicApi = PublicHttpClient.builder(apiUrl);
  final securedApi = SecuredHttpClient.builder(
    apiUrl,
    authTokenStorage: authTokenDbProvider,
    refreshTokenService: publicApi.service<RefreshTokenService>(),
  );

  runApp(SimplioApp(
    accountRepository: AccountRepository.builder(
      db: accountDbProvider,
    ),
    assetWalletRepository: AssetWalletRepository.builder(
      db: assetWalletDbProvider,
    ),
    authRepository: AuthRepository.builder(
      db: accountDbProvider,
      authTokenStorage: authTokenDbProvider,
      signInService: publicApi.service<SignInService>(),
      signUpService: publicApi.service<SignUpService>(),
      passwordChangeService: securedApi.service<PasswordChangeService>(),
      passwordResetService: publicApi.service<PasswordResetService>(),
    ),
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
              _languageChangeCondition(previous, current) ||
              _themeChangeCondition(previous, current),
          builder: (context, state) {
            // set default system bar color
            if (state.account?.settings.themeMode == null) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
            } else {
              SystemChrome.setSystemUIOverlayStyle(
                  state.account?.settings.themeMode == ThemeMode.dark
                      ? SystemUiOverlayStyle.light
                      : SystemUiOverlayStyle.dark);
            }

            return MaterialApp(
              onGenerateTitle: (context) => context.locale.simplioTitle,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: state.account?.settings.locale ??
                  const AccountSettings.preset().locale,
              themeMode: state.account?.settings.themeMode ??
                  const AccountSettings.preset().themeMode,
              theme: LightMode.theme,
              darkTheme: DarkMode.theme,
              home: SplashScreen(
                // prepared for some future data loading or similar stuff
                loadingFunction: () => Future.delayed(
                  const Duration(milliseconds: 1500),
                  () => _routeGuard(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _languageChangeCondition(AccountState previous, AccountState current) {
    return previous.account?.settings.locale.languageCode != null &&
        previous.account?.settings.locale.languageCode !=
            current.account?.settings.locale.languageCode;
  }

  bool _themeChangeCondition(AccountState previous, AccountState current) {
    return previous.account?.settings.themeMode != null &&
        previous.account?.settings.themeMode !=
            current.account?.settings.themeMode;
  }

  Widget _routeGuard() {
    return AuthGuard(
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
    );
  }
}
