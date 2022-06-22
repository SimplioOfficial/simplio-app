part of 'auth_form_cubit.dart';

class AuthFormState extends Equatable {
  final SignInForm signInForm;
  final SignUpForm signUpForm;
  final PasswordChangeForm passwordChangeForm;
  final PasswordResetForm passwordResetForm;
  final AuthFormResponse? response;

  const AuthFormState._({
    required this.signInForm,
    required this.signUpForm,
    required this.passwordChangeForm,
    required this.passwordResetForm,
    this.response,
  });

  const AuthFormState.init()
      : this._(
          signInForm: const SignInForm.init(),
          signUpForm: const SignUpForm.init(),
          passwordChangeForm: const PasswordChangeForm.init(),
          passwordResetForm: const PasswordResetForm.init(),
          response: null,
        );

  @override
  List<Object?> get props => [
        response,
        signInForm,
        signUpForm,
        passwordResetForm,
        passwordChangeForm,
      ];

  AuthFormState copyWith({
    SignInForm? signInForm,
    SignUpForm? signUpForm,
    PasswordChangeForm? passwordChangeForm,
    PasswordResetForm? passwordResetForm,
    AuthFormResponse? response,
  }) {
    return AuthFormState._(
      signInForm: signInForm ?? this.signInForm,
      signUpForm: signUpForm ?? this.signUpForm,
      passwordChangeForm: passwordChangeForm ?? this.passwordChangeForm,
      passwordResetForm: passwordResetForm ?? this.passwordResetForm,
      response: response,
    );
  }
}

// TODO: Implement `email` validation here
class ValidatedEmail {
  final String value;

  const ValidatedEmail({this.value = ''});

  bool get isValid => true;

  @override
  String toString() => value;
}

// TODO: Implement `password` validation here. Return missing rules in a Map;
class ValidatedPassword {
  final String value;

  const ValidatedPassword({this.value = ''});

  bool get isValid => true;

  Map<String, bool> get missingValue => {};

  @override
  String toString() => value;
}

class SignInForm extends Equatable {
  final ValidatedEmail login;
  final ValidatedPassword password;

  const SignInForm._({
    required this.login,
    required this.password,
  });

  const SignInForm.init()
      : this._(
          login: const ValidatedEmail(),
          password: const ValidatedPassword(),
        );

  bool get isValid => login.isValid && password.isValid;

  @override
  List<Object?> get props => [
        login,
        password,
      ];

  SignInForm copyWith({
    String? login,
    String? password,
  }) {
    return SignInForm._(
      login: ValidatedEmail(value: login ?? this.login.toString()),
      password: ValidatedPassword(value: password ?? this.password.toString()),
    );
  }
}

class SignUpForm extends Equatable {
  final ValidatedEmail email;
  final ValidatedPassword password;

  const SignUpForm._({
    required this.email,
    required this.password,
  });

  const SignUpForm.init()
      : this._(
          email: const ValidatedEmail(),
          password: const ValidatedPassword(),
        );

  bool get isValid => email.isValid && password.isValid;

  @override
  List<Object?> get props => [
        email,
        password,
      ];

  SignInForm copyWith({
    String? login,
    String? password,
  }) {
    return SignInForm._(
      login: ValidatedEmail(value: login ?? this.email.toString()),
      password: ValidatedPassword(value: password ?? this.password.toString()),
    );
  }
}

class PasswordChangeForm extends Equatable {
  final String oldPassword;
  final String newPassword;

  const PasswordChangeForm._({
    required this.oldPassword,
    required this.newPassword,
  });

  const PasswordChangeForm.init()
      : this._(
          oldPassword: '',
          newPassword: '',
        );

  @override
  List<Object?> get props => [
        oldPassword,
        newPassword,
      ];

  PasswordChangeForm copyWith({
    String? oldPassword,
    String? newPassword,
  }) {
    return PasswordChangeForm._(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}

class PasswordResetForm extends Equatable {
  final String email;

  const PasswordResetForm._({required this.email});

  const PasswordResetForm.init() : this._(email: '');

  @override
  List<Object?> get props => [email];

  PasswordResetForm copyWith({
    String? email,
  }) {
    return PasswordResetForm._(
      email: email ?? this.email,
    );
  }
}

abstract class AuthFormResponse extends Equatable {
  const AuthFormResponse();
}

class SignInFormPending extends AuthFormResponse {
  const SignInFormPending();

  @override
  List<Object?> get props => [];
}

class SignInFormSuccess extends AuthFormResponse {
  final Account account;

  const SignInFormSuccess({required this.account});

  @override
  List<Object?> get props => [account];
}

class SignInFormFailure extends AuthFormResponse {
  final Exception exception;

  const SignInFormFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
