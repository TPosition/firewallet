import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_repository/users_repository.dart';

part 'select_account_state.dart';

class SelectAccountCubit extends Cubit<SelectAccountState> {
  SelectAccountCubit({required final List<User> users})
      : _users = users,
        super(const SelectAccountState());

  final List<User> _users;

  void init() {
    emit(state.copyWith(usersList: _users));
  }

  void searchChanged(final String value) {
    final List<User?> filtered = state.usersList.map((final user) {
      if (user.mobile.toLowerCase().contains(value.toLowerCase()) ||
          user.displayName.toLowerCase().contains(value.toLowerCase())) {
        return user;
      }
      return null;
    }).toList();
    emit(state.copyWith(filteredUsersList: filtered));
  }
}
