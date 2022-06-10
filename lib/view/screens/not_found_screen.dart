import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  final String? page;

  const NotFoundScreen({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text('404 Screen not found'),
            ),
            Center(
              child: Text('Route: ${page ?? 'empty'}'),
            ),
          ],
        ),
      ),
    );
  }
}
