import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/wallet/wallet_bloc.dart';
import 'package:simplio_app/view/screens/dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) => WalletBloc()),
        ],
        child: MaterialApp(
          title: 'Simplio',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const DashboardScreen(),
        ));
  }
}