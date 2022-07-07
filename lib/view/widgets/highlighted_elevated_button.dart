import 'package:flutter/material.dart';

class HighlightedElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;

  const HighlightedElevatedButton({super.key, this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) =>
              states.isNotEmpty && states.first == MaterialState.pressed
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.onSurface),
        ),
        onPressed: onPressed,
        child: child);
  }
}
