import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/view/utils/localizations.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(const GotUnauthenticated());
              },
              child: Text(AppLocalizations.of(context)!.logoutBtn),
            ),
            ElevatedButton(
              onPressed: () {
                var currentLanguage = AppLocalizations.of(context)!.localeName;
                var newLanguage = AppLocalizations.supportedLanguageCodes
                    .firstWhere((element) => element != currentLanguage);

                context.read<AccountCubit>().setLanguage(newLanguage);
              },
              child: Text(AppLocalizations.of(context)!.switchLanguage),
            ),
          ],
        ),
      ),
    );
  }
}
