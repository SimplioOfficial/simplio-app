import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/l10n/localized_build_context_extension.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';
import 'package:simplio_app/logic/auth_form_cubit/auth_form_cubit.dart';
import 'package:simplio_app/logic/security_form_cubit/security_form_cubit.dart';
import 'package:simplio_app/view/themes/common_theme.dart';
import 'package:simplio_app/view/widgets/headline_text.dart';
import 'package:simplio_app/view/widgets/highlighted_elevated_button.dart';
import 'package:simplio_app/view/widgets/pin_digits.dart';
import 'package:simplio_app/view/widgets/pin_numpad.dart';

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PinSetScreen();
}

class _PinSetScreen extends State<PinSetupScreen> {
  int _step = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: _getScreenStep(_step),
        ),
      );

  Widget _getScreenStep(int step) {
    Widget widget;
    switch (step) {
      case 0:
        widget = Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: CommonTheme.bottomPadding,
              child: Center(
                child:
                    HeadlineText(context.locale.accountCreationBeforePinSetup),
              ),
            ),
            Padding(
              padding: CommonTheme.bottomPadding,
              child: SizedBox(
                width: 250,
                child: Text(context.locale.setPinLabel,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ),
            BlocBuilder<SecurityFormCubit, SecurityFormState>(
              buildWhen: (prev, curr) =>
                  prev.setupPinForm.pin != curr.setupPinForm.pin,
              builder: (context, state) => PinDigits(
                pin: state.setupPinForm.pin,
                pinDigitStyle: PinDigitStyle.hideAllAfterTime,
                duration: const Duration(seconds: 1),
              ),
            ),
            BlocBuilder<SecurityFormCubit, SecurityFormState>(
              buildWhen: (prev, curr) =>
                  prev.setupPinForm.pin != curr.setupPinForm.pin,
              builder: (context, state) => PinNumpad(
                displayNextButton: context
                    .read<SecurityFormCubit>()
                    .state
                    .setupPinForm
                    .isValid,
                onChange: (pin) => context
                    .read<SecurityFormCubit>()
                    .changeSetupPinForm(pin: pin),
                onNextButtonClicked: (_) => setState(() => _step++),
              ),
            ),
          ],
        );
        break;
      case 1:
      default:
        widget = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: CommonTheme.bottomPadding,
                        child: HeadlineText(context.locale.accountCreatedLabel),
                      ),
                      Text(
                        context.locale.accountCreatedDescriptionLabel,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: CommonTheme.horizontalPadding,
              child: SizedBox(
                width: double.infinity,
                child: HighlightedElevatedButton(
                  onPressed: () => context.read<AuthBloc>().add(
                      GotAuthenticated(
                          accountId: context
                              .read<AuthFormCubit>()
                              .state
                              .signUpForm
                              .login
                              .value)),
                  child: Text(
                    context.locale.loginBtn,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
        break;
    }

    return widget;
  }
}
