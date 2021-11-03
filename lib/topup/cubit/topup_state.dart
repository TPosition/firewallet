part of 'topup_cubit.dart';

class TopupState extends Equatable {
  const TopupState({
    final this.amount = 0,
    final this.status = FormzStatus.pure,
  });

  final double amount;
  final FormzStatus status;

  @override
  List<Object> get props => [amount, status];

  TopupState copyWith({
    final double? amount,
    final FormzStatus? status,
  }) =>
      TopupState(
        amount: amount ?? this.amount,
        status: status ?? this.status,
      );
}
