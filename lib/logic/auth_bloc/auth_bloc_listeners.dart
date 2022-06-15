import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/logic/account_cubit/account_cubit.dart';
import 'package:simplio_app/logic/auth_bloc/auth_bloc.dart';

class AuthBlocListeners {
  AuthBlocListeners._();

  static BlocListener<AuthBloc, AuthState> clearAccountAfterLogout =
  BlocListener<AuthBloc, AuthState>(
    listenWhen: (previous, current) => current is Unauthenticated,
    listener: (context, state) => context.read<AccountCubit>().loadAccount(''),
  );
}
