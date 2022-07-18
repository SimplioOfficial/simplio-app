import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simplio_app/logic/security_form_cubit/security_form_cubit.dart';

enum PinDigitStyle { hideAllExceptLast, hideAllAfterTime, showAll }

class PinDigits extends StatefulWidget {
  final int pinLength;
  final PinDigitStyle pinDigitStyle;
  final Duration duration;
  final List<int>? pin;

  const PinDigits({
    super.key,
    this.pin,
    this.pinLength = SecurityFormState.pinLength,
    this.pinDigitStyle = PinDigitStyle.hideAllAfterTime,
    this.duration = const Duration(milliseconds: 1000),
  });

  @override
  State<PinDigits> createState() => _PinDigitsState();
}

class _PinDigitsState extends State<PinDigits> {
  List<String> _displayedPin = [];
  Timer? _characterHidingTimer;

  @override
  void dispose() {
    _characterHidingTimer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);

    if ((widget.pin?.length ?? 0) > (oldWidget.pin?.length ?? 0)) {
      if (widget.pin != null) {
        _displayedPin.add(widget.pin![widget.pin!.length - 1].toString());
      }
    }

    switch (widget.pinDigitStyle) {
      case PinDigitStyle.hideAllAfterTime:
        if (_characterHidingTimer != null) {
          Timer timer = _characterHidingTimer!;
          timer.cancel();
          _hideAllExceptLast();
        }

        _characterHidingTimer = Timer(
          widget.duration,
          () => setState(
              () => _displayedPin = widget.pin?.map((e) => '⦁').toList() ?? []),
        );
        break;
      case PinDigitStyle.hideAllExceptLast:
        _hideAllExceptLast();
        break;
      case PinDigitStyle.showAll:
        // do nothing
        break;
    }
  }

  void _hideAllExceptLast() {
    setState(() => _displayedPin = widget.pin
            ?.asMap()
            .entries
            .map((e) =>
                e.key != widget.pin!.length - 1 ? '⦁' : e.value.toString())
            .toList() ??
        []);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pinNumbers = [];
    for (int i = 0; i < widget.pinLength; i++) {
      pinNumbers.add(_PinNumber(
        char: _getPin(i),
        key: Key('pin-digit-index-$i'),
      ));
    }

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pinNumbers,
      ),
    ]);
  }

  String _getPin(int index) {
    if (_displayedPin.length - 1 < index) return '';

    return _displayedPin[index].toString();
  }
}

class _PinNumber extends StatelessWidget {
  final String? char;

  const _PinNumber({super.key, required this.char});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.5),
      child: Container(
        alignment: Alignment.center,
        width: 59,
        height: 59,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: const BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Text(
          key: key,
          char ?? '',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
            fontWeight: Theme.of(context).textTheme.headlineMedium?.fontWeight,
          ),
        ),
      ),
    );
  }
}
