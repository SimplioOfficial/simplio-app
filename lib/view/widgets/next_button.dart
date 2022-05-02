import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final bool isValid;
  final VoidCallback onPressed;
  final String text;

  const NextButton(
      {required this.isValid,
      required this.onPressed,
      this.text = 'Next',
      key = const Key('next_button')})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: ElevatedButton(
        key: key,
        child: Text(text),
        onPressed: isValid ? onPressed : null,
      ),
    );
  }
}
