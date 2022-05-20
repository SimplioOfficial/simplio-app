import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:simplio_app/data/providers/account_db_provider.dart';
import 'package:simplio_app/data/repositories/account_repository.dart';
import 'package:simplio_app/logic/account_bloc/account_bloc.dart';
import 'package:simplio_app/view/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final accountRepository =
      await AccountRepository.builder(db: AccountDbProvider()).init();

  runApp(SimplioApp(
    accountRepository: accountRepository,
  ));
}

class SimplioApp extends StatefulWidget {
  final AccountRepository accountRepository;

  const SimplioApp({Key? key, required this.accountRepository})
      : super(key: key);

  @override
  State<SimplioApp> createState() => _SimplioAppState();
}

class _SimplioAppState extends State<SimplioApp> {
  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.accountRepository),
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
          initialRoute: AppRouter.home,
          onGenerateRoute: _router.generateRoute,
        ),
      ),
    );
  }
}
