import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/cubit/balance_states.dart';

class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit()
      : super(UpdateBalanceState(
          balance: 0,
          transactions: [],
          pendingFees: 0,
          lastPaymentDate: '__',
        ));

  void rechargeBalance(double amount) {
    if (state is UpdateBalanceState) {
      final currentState = state as UpdateBalanceState;
      final newTransaction = {
        "amount": "$amount LE",
        "date": DateTime.now().toIso8601String().split('T')[0],
      };
      emit(currentState.copyWith(
        balance: currentState.balance + amount,
        transactions: [...currentState.transactions, newTransaction],
      ));
    }
  }

  void makePayment(double selectedFees, double totalFees) {
    if (state is UpdateBalanceState) {
      final currentState = state as UpdateBalanceState;
      if (currentState.balance >= selectedFees) {
        emit(currentState.copyWith(
          balance: currentState.balance - selectedFees,
          pendingFees: totalFees - selectedFees,
          lastPaymentDate: DateTime.now().toIso8601String().split('T')[0],
        ));
      } else {
        print('Insufficient balance to pay');
      }
    }
  }
}
