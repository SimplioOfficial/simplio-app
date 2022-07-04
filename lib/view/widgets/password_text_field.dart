import 'package:flutter/material.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';

class PasswordTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool Function(String password) passwordComplexityCondition;
  final bool autofocus;
  final String? labelText;
  final IconData displayedIcon;
  final IconData icon;
  final FormFieldValidator<String>? validator;

  const PasswordTextField({
    super.key,
    required this.passwordComplexityCondition,
    this.onChanged,
    this.autofocus = false,
    this.labelText,
    this.displayedIcon = Icons.visibility_outlined,
    this.icon = Icons.visibility_off_outlined,
    this.onTap,
    this.validator,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isDisplayed = true;
  bool isComplexitySatisfied = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isDisplayed,
      autofocus: widget.autofocus,
      validator: widget.validator,
      onChanged: (String? password) {
        if (password != null) {
          widget.onChanged?.call(password);
          setState(() => isComplexitySatisfied =
              widget.passwordComplexityCondition(password));
        }
      },
      style: TextStyle(
        color: isComplexitySatisfied
            ? Theme.of(context).colorScheme.tertiary
            : Theme.of(context).colorScheme.error,
      ),
      obscuringCharacter: '⦁',
      // obscuringCharacter: '●',
      // obscuringCharacter: '﹡',
      // obscuringCharacter: '⁕',
      decoration: InputDecoration(
        labelText: widget.labelText ?? context.locale.passwordInputLabel,
        hintText: widget.labelText ?? context.locale.passwordInputLabel,
        suffixIcon: IconButton(
            icon: Icon(_isDisplayed ? widget.displayedIcon : widget.icon),
            onPressed: () {
              setState(() {
                _isDisplayed = !_isDisplayed;
              });
            }),
      ),
      onTap: widget.onTap,
    );
  }
}
