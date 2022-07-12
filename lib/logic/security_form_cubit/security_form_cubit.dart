import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplio_app/data/model/account.dart';

part 'security_form_state.dart';

class SecurityFormCubit extends Cubit<SecurityFormState> {
  SecurityFormCubit._() : super(const SecurityFormState.init());

  SecurityFormCubit.builder() : this._();

  void changeSetupPinForm({List<int>? pin}) {
    emit(state.copyWith(
      setupPinForm: state.setupPinForm.copyWith(pin: [...pin ?? []]),
    ));
  }

  Future<void> requestSetupPin() async {
    emit(state.copyWith(response: const SetupPinFormPending()));

    // todo: fill in the logic
  }
}
