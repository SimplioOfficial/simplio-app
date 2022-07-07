import 'package:flutter/material.dart';
import 'package:simplio_app/view/themes/common_theme.dart';

class BorderedElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? child;

  const BorderedElevatedButton({super.key, this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) =>
              states.isNotEmpty && states.first == MaterialState.pressed
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).colorScheme.primary),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: CommonTheme.buttonBorderRadius,
              side: BorderSide(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child);
  }
}
