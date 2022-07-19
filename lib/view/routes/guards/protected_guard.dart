import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';

/// This guard should protect inherited screen
/// with showed pin calculator,
class ProtectedGuard extends StatefulWidget {
  final int attemptLimit;
  final Widget protectedChild;
  final Function(BuildContext context) onPrevent;

  const ProtectedGuard({
    super.key,
    this.attemptLimit = 3,
    required this.protectedChild,
    required this.onPrevent,
  }) : assert(attemptLimit > 0);

  @override
  State<ProtectedGuard> createState() => _ProtectedGuardState();
}

class _ProtectedGuardState extends State<ProtectedGuard> {
  int currentAttempt = 0;
  bool isVerified = false;

  @override
  Widget build(BuildContext context) {
    // 1. Show a Pin screen
    return isVerified
        ? widget.protectedChild
        : _Protection(
            onFailure: widget.onPrevent,
            onSuccess: (context) => setState(() {
              isVerified = true;
            }),
          );
  }
}

class _Protection extends StatelessWidget {
  final Function(BuildContext context) onSuccess;
  final Function(BuildContext context) onFailure;

  const _Protection({
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text('Enter your pin'),
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  final res = context.read<AccountCubit>().verifyPin('1234');
                  final fn = res ? onSuccess : onFailure;
                  fn(context);
                },
                child: const Text('Success'),
              ),
              ElevatedButton(
                onPressed: () {
                  onFailure(context);
                },
                child: const Text('Failure'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
