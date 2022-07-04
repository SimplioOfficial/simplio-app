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
        signUpForm.password.missingValue
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

class ValidatedEmail {
  final String value;

  const ValidatedEmail({this.value = ''});

  bool get isValid => _emailValidator(value);

  @override
  String toString() => value;

  String? emailValidator(String? email, BuildContext context) {
    if (_emailValidator(email)) return null;

    return context.locale.emailValidationError;
  }

  bool _emailValidator(String? value) {
    return value!.contains(RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\])|(([a-zA-Z\-\d]+\.)+[a-zA-Z]{2,}))$'));
  }
}

class ValidatedPassword {
  final String value;

  const ValidatedPassword({this.value = ''});

  bool get isValid => _validatePassword(value);

  String? passwordValidator(String? password, BuildContext context) {
    if (_validatePassword(password)) return null;

    return context.locale.passwordValidationError;
  }

  bool _validatePassword(String? password) {
    return _hasSpecialCharacters(password) &&
        _hasUpperCharacters(password) &&
        _hasNumbers(password) &&
        _isLongEnough(password);
  }

  Map<String, bool> get missingValue => {
        'specialChar': _hasSpecialCharacters(value),
        'upperChar': _hasUpperCharacters(value),
        'numberChar': _hasNumbers(value),
        'length': _isLongEnough(value),
      };

  @override
  String toString() => value;

  bool _hasSpecialCharacters(String? value) {
    Pattern specialCharRegexp =
        RegExp(r'''^(?=.*[ `!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~])''');

    return value!.contains(specialCharRegexp);
  }

  bool _hasUpperCharacters(String? value) {
    Pattern upperCharRegexp = RegExp(r'''^(?=.*[A-Z])''');

    return value!.contains(upperCharRegexp);
  }

  bool _hasNumbers(String? value) {
    Pattern numbersRegexp = RegExp(r'''^(?=.*[0-9])''');

    return value!.contains(numbersRegexp);
  }

  bool _isLongEnough(String? value) {
    return value!.length >= 8;
  }
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
  final ValidatedEmail login;
  final ValidatedPassword password;

  const SignUpForm._({
    required this.login,
    required this.password,
  });

  const SignUpForm.init()
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

  SignUpForm copyWith({
    String? login,
    String? password,
  }) {
    return SignUpForm._(
      login: ValidatedEmail(value: login ?? this.login.toString()),
      password: ValidatedPassword(value: password ?? this.password.toString()),
    );
  }
}

class PasswordChangeForm extends Equatable {
  final ValidatedPassword oldPassword;
  final ValidatedPassword newPassword;

  const PasswordChangeForm._({
    required this.oldPassword,
    required this.newPassword,
  });

  const PasswordChangeForm.init()
      : this._(
          oldPassword: const ValidatedPassword(),
          newPassword: const ValidatedPassword(),
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
      oldPassword:
          ValidatedPassword(value: oldPassword ?? this.oldPassword.toString()),
      newPassword:
          ValidatedPassword(value: newPassword ?? this.newPassword.toString()),
    );
  }
}

class PasswordResetForm extends Equatable {
  final ValidatedEmail email;

  const PasswordResetForm._({required this.email});

  const PasswordResetForm.init() : this._(email: const ValidatedEmail());

  @override
  List<Object?> get props => [email];

  PasswordResetForm copyWith({
    String? email,
  }) {
    return PasswordResetForm._(
      email: ValidatedEmail(value: email ?? this.email.toString()),
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
