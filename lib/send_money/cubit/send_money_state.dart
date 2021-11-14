part of 'send_money_cubit.dart';

class SendMoneyState extends Equatable {
  const SendMoneyState({
    final this.amount = 0,
    final this.status = FormzStatus.pure,
    final this.isEnough = true,
  });

  final double amount;
  final FormzStatus status;
  final bool isEnough;

  @override
  List<Object> get props => [amount, status, isEnough];

  SendMoneyState copyWith({
    final double? amount,
    final FormzStatus? status,
    final bool? isEnough,
  }) =>
      SendMoneyState(
        amount: amount ?? this.amount,
        status: status ?? this.status,
        isEnough: isEnough ?? this.isEnough,
      );
}
