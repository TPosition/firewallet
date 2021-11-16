import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_firebase_login/transactions/transaction_category_contant.dart';
import 'package:transactions_repository/transactions_repository.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(
      {required final List<Transaction> transactions,
      required final String uid})
      : _transactions = transactions,
        _uid = uid,
        super(const HistoryState());

  final List<Transaction> _transactions;
  final String _uid;

  void init() {
    emit(state.copyWith(transactionsList: _transactions));
  }

  void searchChanged(final int value) {
    if (value == 1) {
      emit(state.copyWith(filteredTransactionsList: []));
    }
    if (value == 2) {
      final List<Transaction?> filtered =
          state.transactionsList.map((final transaction) {
        if (transaction.category == ktransfer &&
            transaction.senderUID == _uid) {
          return transaction;
        }
        return null;
      }).toList();

      emit(state.copyWith(filteredTransactionsList: filtered));
    }

    if (value == 3) {
      final List<Transaction?> filtered =
          state.transactionsList.map((final transaction) {
        if (transaction.category == ktransfer &&
            transaction.receiverUID == _uid) {
          return transaction;
        }
        return null;
      }).toList();

      emit(state.copyWith(filteredTransactionsList: filtered));
    }

    if (value == 4) {
      final List<Transaction?> filtered =
          state.transactionsList.map((final transaction) {
        if (transaction.category == ktopup) {
          return transaction;
        }
        return null;
      }).toList();

      emit(state.copyWith(filteredTransactionsList: filtered));
    }
  }

  void datePicked(final DateTime picked) {
    print(picked);

    final List<Transaction?> filtered =
        state.transactionsList.map((final transaction) {
      if (transaction.timestamp.year == picked.year &&
          transaction.timestamp.month == picked.month &&
          transaction.timestamp.day == picked.day) {
        return transaction;
      }
      return null;
    }).toList();

    emit(state.copyWith(filteredTransactionsList: filtered));
  }
}
