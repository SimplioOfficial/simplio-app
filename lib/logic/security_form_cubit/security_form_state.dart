part of 'security_form_cubit.dart';

class SecurityFormState extends Equatable {
  final SetupPinForm setupPinForm;
  final PinFormResponse? response;

  static const pinLength = 4;

  const SecurityFormState._({
    required this.setupPinForm,
    this.response,
  });

  const SecurityFormState.init()
      : this._(
          setupPinForm: const SetupPinForm.init(),
          response: null,
        );

  @override
  List<Object?> get props => [
        setupPinForm,
        response,
      ];

  SecurityFormState copyWith({
    SetupPinForm? setupPinForm,
    PinFormResponse? response,
  }) {
    return SecurityFormState._(
      setupPinForm: setupPinForm ?? this.setupPinForm,
      response: response,
    );
  }
}

class SetupPinForm extends Equatable {
  final List<int> pin;

  const SetupPinForm._({required this.pin});

  const SetupPinForm.init() : this._(pin: const <int>[]);

  bool get isValid => pin.length == SecurityFormState.pinLength;

  @override
  List<Object?> get props => [pin];

  SetupPinForm copyWith({List<int>? pin}) {
    return SetupPinForm._(pin: pin ?? this.pin);
  }
}

abstract class PinFormResponse extends Equatable {
  const PinFormResponse();
}

class SetupPinFormPending extends PinFormResponse {
  const SetupPinFormPending();

  @override
  List<Object?> get props => [];
}

class SetupPinFormSuccess extends PinFormResponse {
  final Account account;

  const SetupPinFormSuccess({required this.account});

  @override
  List<Object?> get props => [account];
}

class SetupPinFailure extends PinFormResponse {
  final Exception exception;

  const SetupPinFailure({required this.exception});

  @override
  List<Object?> get props => [exception];
}
