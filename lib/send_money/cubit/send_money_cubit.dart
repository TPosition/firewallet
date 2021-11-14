import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'send_money_state.dart';

class SendMoneyCubit extends Cubit<SendMoneyState> {
  SendMoneyCubit() : super(const SendMoneyState());

  void amountChanged(final String value, final double balance) {
    if (value.isNotEmpty) {
      if (balance > double.parse(value)) {
        emit(
          state.copyWith(
            amount: double.parse(value),
            status: FormzStatus.valid,
            isEnough: true,
          ),
        );
      }
      emit(state.copyWith(isEnough: false));
    }
  }

  void submitOnPress() {
    if (!state.status.isValidated) return;

    emit(
      state.copyWith(
        status: FormzStatus.submissionSuccess,
      ),
    );
  }
}
