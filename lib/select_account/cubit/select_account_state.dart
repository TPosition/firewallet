part of 'select_account_cubit.dart';

class SelectAccountState extends Equatable {
  const SelectAccountState({
    final this.usersList = const [],
    final this.filteredUsersList = const [],
  });

  final List<User> usersList;
  final List<User?> filteredUsersList;

  @override
  List<Object> get props => [
        usersList,
        filteredUsersList,
      ];

  SelectAccountState copyWith({
    final List<User>? usersList,
    final List<User?>? filteredUsersList,
  }) =>
      SelectAccountState(
        usersList: usersList ?? this.usersList,
        filteredUsersList: filteredUsersList ?? this.filteredUsersList,
      );
}
