import 'package:flutter/material.dart';
import 'package:simplio_app/view/themes/common_theme.dart';

class SplashScreen extends StatelessWidget {
  final Future<Widget> Function() loadingFunction;

  const SplashScreen({super.key, required this.loadingFunction});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: loadingFunction(),
      initialData: _splashScreenWidget(context),
      builder: (context, snapshot) =>
          snapshot.data ?? const Text('Unexpected error'),
    );
  }

  Widget _splashScreenWidget(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/icon/icon_blue.png',
                    width: 48,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Simplio',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.fontSize),
                  ),
                ],
              ),
              Padding(
                padding: CommonTheme.verticalPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 3,
                      width: 220,
                      child: LinearProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                        backgroundColor: Theme.of(context).highlightColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: CommonTheme.bottomPadding,
                  child: const Text('Built with Flutter 3'),
                ),
              )
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
