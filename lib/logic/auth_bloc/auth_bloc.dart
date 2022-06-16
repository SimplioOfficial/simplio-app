import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/account.dart';
import 'package:simplio_app/data/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc.builder({
    required AuthRepository authRepository,
  }) : this._(authRepository);

  AuthBloc._(this._authRepository) : super(const Unauthenticated()) {
    on<GotAuthenticated>(_onGotAuthenticated);
    on<GotUnauthenticated>(_onGotUnauthenticated);
    on<GotLastAuthenticated>(_onGotLastAuthenticated);
  }

  Future<void> _onGotAuthenticated(
    GotAuthenticated event,
    Emitter<AuthState> emit,
  ) async {
    emit(Authenticated(accountId: event.accountId));
  }

  void _onGotUnauthenticated(
    GotUnauthenticated event,
    Emitter<AuthState> emit,
  ) {
    final s = state;
    if (s is Authenticated) {
      _authRepository.logout(accountId: s.accountId);
    }

    emit(const Unauthenticated());
  }

  void _onGotLastAuthenticated(
    GotLastAuthenticated event,
    Emitter<AuthState> emit,
  ) {
    final Account? account = _authRepository.lastLoggedIn();

    emit(
      account != null
          ? Authenticated(accountId: account.id)
          : const Unauthenticated(),
    );
  }
}
