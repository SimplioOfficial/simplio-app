import 'package:flutter/material.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/view/routes/unauthenticated_route.dart';
import 'package:simplio_app/view/themes/common_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Center(
                child: Text(context.locale.welcomeLabel),
              ),
            ),
            Padding(
              padding: CommonTheme.paddingAll,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(UnauthenticatedRoute.login);
                  },
                  child:
                      Text(context.locale.enterApplicationLabel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
