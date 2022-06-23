import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final String labelText;
  final IconData displayedIcon;
  final IconData icon;

  const PasswordTextField({
    super.key,
    this.onChanged,
    this.autofocus = false,
    this.labelText = 'Password',
    this.displayedIcon = Icons.visibility,
    this.icon = Icons.visibility_off,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isDisplayed = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _isDisplayed,
      autofocus: widget.autofocus,
      onChanged: (String? password) {
        if (password != null) {
          widget.onChanged?.call(password);
        }
      },
      decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: IconButton(
              icon:
                  Icon(_isDisplayed ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isDisplayed = !_isDisplayed;
                });
              })),
    );
  }
}
