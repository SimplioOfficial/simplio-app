import 'package:flutter/material.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/view/routes/unauthenticated_route.dart';
import 'package:simplio_app/view/themes/common_theme.dart';
import 'package:simplio_app/view/widgets/bordered_elevated_button.dart';
import 'package:simplio_app/view/widgets/highlighted_elevated_button.dart';
import 'package:simplio_app/view/widgets/story.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Story(
          repeat: true,
          itemDuration: const Duration(seconds: 2),
          items: [
            Container(
              width: double.infinity,
              color: Colors.red,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Placeholder 1',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineLarge?.fontSize),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.green,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Placeholder 2',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineLarge?.fontSize),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.orange,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Placeholder 3',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineLarge?.fontSize),
                ),
              ),
            ),
          ],
          bottomNavigationBar: Padding(
            padding: CommonTheme.horizontalPadding,
            child: Column(
              children: [
                Padding(
                  padding: CommonTheme.bottomPadding,
                  child: SizedBox(
                    width: double.infinity,
                    child: HighlightedElevatedButton(
                      onPressed: () => {},
                      child: Text(context.locale.goToAppBtn),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: BorderedElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(UnauthenticatedRoute.signIn);
                    },
                    child: Text(context.locale.signInButtonLabel),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
