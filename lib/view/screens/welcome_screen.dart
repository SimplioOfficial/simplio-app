import 'package:flutter/material.dart';
import 'package:simplio_app/view/routes/unauthenticated_route.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Expanded(
            child: Center(
              child: Text('Welcome to Simplio'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(UnauthenticatedRoute.login);
                },
                child: const Text('I have an account'),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
