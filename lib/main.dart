import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/wallet_bloc/wallet_bloc.dart';
import 'package:simplio_app/view/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
  ));

  runApp(const SimplioApp());
}

class SimplioApp extends StatefulWidget {
  const SimplioApp({Key? key}) : super(key: key);

  @override
  State<SimplioApp> createState() => _SimplioAppState();
}

class _SimplioAppState extends State<SimplioApp> {
  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WalletBloc()),
      ],
      child: MaterialApp(
        title: 'Simplio',
        initialRoute: AppRouter.home,
        onGenerateRoute: _router.generateRoute,
      ),
    );
  }
}
