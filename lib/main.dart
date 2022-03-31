import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:simplio_app/view/router/app_router.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
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
  void initState() {
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simplio',
      initialRoute: AppRouter.home,
      onGenerateRoute: _router.generateRoute,
    );
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  void initialization() async {
    // TODO: implement database initialization or any other time-consuming stuff
    FlutterNativeSplash.remove();
  }
}
