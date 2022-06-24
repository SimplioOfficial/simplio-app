import 'package:flutter/material.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/view/routes/authenticated_route.dart';
import 'package:simplio_app/view/themes/common_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: CommonTheme.paddingAll,
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.6,
          children: [
            Material(
              clipBehavior: Clip.hardEdge,
              color: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: CommonTheme.borderRadius,
                side: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              child: InkWell(
                onTap: () {
                  AuthenticatedRoute.key.currentState
                      ?.pushReplacementNamed(AuthenticatedRoute.inventory);
                },
                child: Padding(
                  padding: CommonTheme.paddingAll,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.locale.gamesLabel),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.sports_esports_outlined,
                          size: 32.0,
                          color: Theme.of(context).textTheme.titleMedium?.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              color: Theme.of(context).colorScheme.error,
              shape: RoundedRectangleBorder(
                borderRadius: CommonTheme.borderRadius,
              ),
            ),
            Material(
              color: Theme.of(context).colorScheme.error,
              shape: RoundedRectangleBorder(
                borderRadius: CommonTheme.borderRadius,
              ),
            ),
            Material(
              color: Theme.of(context).colorScheme.error,
              shape: RoundedRectangleBorder(
                borderRadius: CommonTheme.borderRadius,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
