import 'package:flutter/material.dart';
import 'package:simplio_app/view/themes/common_theme.dart';

class PinNumpad extends StatefulWidget {
  final bool displayNextButton;
  final ValueChanged<List<int>>? onNextButtonClicked;
  final ValueChanged<List<int>>? onChange;

  const PinNumpad({
    super.key,
    required this.displayNextButton,
    this.onNextButtonClicked,
    this.onChange,
  });

  @override
  State<StatefulWidget> createState() => _PinNumpadState();
}

class _PinNumpadState extends State<PinNumpad> {
  final List<int> _result = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _NumpadButton(
                number: 1, onTap: _onTap(1), key: const Key('numpad-button-1')),
            _NumpadButton(
                number: 2, onTap: _onTap(2), key: const Key('numpad-button-2')),
            _NumpadButton(
                number: 3, onTap: _onTap(3), key: const Key('numpad-button-3')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _NumpadButton(
                number: 4, onTap: _onTap(4), key: const Key('numpad-button-4')),
            _NumpadButton(
                number: 5, onTap: _onTap(5), key: const Key('numpad-button-5')),
            _NumpadButton(
                number: 6, onTap: _onTap(6), key: const Key('numpad-button-6')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _NumpadButton(
                number: 7, onTap: _onTap(7), key: const Key('numpad-button-7')),
            _NumpadButton(
                number: 8, onTap: _onTap(8), key: const Key('numpad-button-8')),
            _NumpadButton(
                number: 9, onTap: _onTap(9), key: const Key('numpad-button-9')),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _result.isEmpty
                ? const _NumpadButton()
                : _ActionButton(
                    key: const Key('backspace-button'),
                    onTap: _onBackspaceTap(),
                    child: Icon(
                      Icons.backspace_outlined,
                      size: 32.0,
                      color: Theme.of(context).textTheme.titleMedium?.color,
                    ),
                  ),
            _NumpadButton(
                number: 0, onTap: _onTap(0), key: const Key('numpad-button-0')),
            widget.displayNextButton
                ? _ActionButton(
                    key: const Key('next-button'),
                    onTap: () {
                      if (widget.onNextButtonClicked != null) {
                        widget.onNextButtonClicked!(_result);
                      }
                    },
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 32.0,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),
                  )
                : const _NumpadButton(),
          ],
        ),
      ],
    );
  }

  GestureTapCallback _onTap(int number) {
    return () {
      if (widget.displayNextButton) return;

      _result.add(number);
      if (widget.onChange != null) widget.onChange!(_result);
    };
  }

  GestureTapCallback _onBackspaceTap() {
    return () {
      if (_result.isEmpty) return;

      _result.removeLast();
      if (widget.onChange != null) widget.onChange!(_result);
    };
  }
}

class _NumpadButton extends StatelessWidget {
  final num? number;
  final GestureTapCallback? onTap;

  const _NumpadButton({super.key, this.number, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: key,
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: CommonTheme.paddingAll,
        child: Container(
          alignment: Alignment.center,
          width: _ButtonSizes.width,
          height: _ButtonSizes.height,
          child: Text(
            number != null ? number.toString() : '',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
              fontWeight:
                  Theme.of(context).textTheme.headlineMedium?.fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final Widget child;
  final GestureTapCallback onTap;

  const _ActionButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: key,
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: CommonTheme.paddingAll,
        child: Container(
          alignment: Alignment.center,
          width: _ButtonSizes.width,
          height: _ButtonSizes.height,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _ButtonSizes {
  static double width = 59;
  static double height = 52;
}
