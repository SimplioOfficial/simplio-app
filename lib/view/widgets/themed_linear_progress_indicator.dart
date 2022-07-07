import 'package:flutter/material.dart';

class ThemedLinearProgressIndicator extends StatelessWidget {
  final double? value;

  const ThemedLinearProgressIndicator({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).highlightColor,
      value: value,
    );
  }
}
