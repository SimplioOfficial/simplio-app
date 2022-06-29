import 'package:flutter/material.dart';

class ThemedTextFormFiled extends StatelessWidget {
  final bool autofocus;
  final FormFieldValidator<String>? validator;
  final InputDecoration? decoration;
  final ValueChanged<String>? onChanged;
  final ValueChanged<bool>? onFocusChange;
  final TextInputType? keyboardType;
  final TextStyle? style;

  const ThemedTextFormFiled({
    super.key,
    this.autofocus = false,
    this.validator,
    this.decoration,
    this.onChanged,
    this.keyboardType,
    this.style,
    this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: onFocusChange,
      child: TextFormField(
        key: key,
        autofocus: autofocus,
        validator: validator,
        decoration: decoration,
        onChanged: onChanged,
        keyboardType: keyboardType,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ).merge(style),
      ),
    );
  }
}
