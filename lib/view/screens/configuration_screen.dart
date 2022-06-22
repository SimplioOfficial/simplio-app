import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/view/routes/authenticated_route.dart';

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('Change password'),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AuthenticatedRoute.passwordChange);
              },
            ),
            ElevatedButton(
              child: const Text('Sign out'),
              onPressed: () {
                context.read<AuthBloc>().add(const GotUnauthenticated());
              },
            ),
          ],
        ),
      ),
    );
  }
}
