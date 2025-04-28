import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/cubit/balance_states.dart';
//import 'package:gatehub/services/api_consumer.dart';
import 'package:intl/intl.dart';  


class BalanceCubit extends Cubit<BalanceState> {
  BalanceCubit(): super(BalanceInitial());
  //[ApiConsumer? apiConsumer]


 double balance = 0.0;
  double pendingFees = 0.0;
  String lastPaymentDate = '';

void setInitialData({required double balance, required double pendingFees, required String lastPaymentDate}) {
    this.balance = balance;
    this.pendingFees = pendingFees;
    this.lastPaymentDate = lastPaymentDate;
    emit(UpdateBalanceState(balance: balance, pendingFees: pendingFees, lastPaymentDate: lastPaymentDate, transactions: []));
  }


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
         String formattedDate = DateFormat('d/MM/yyyy').format(DateTime.now());
         
        emit(currentState.copyWith(
          balance: currentState.balance - selectedFees,
          pendingFees: totalFees - selectedFees,
          lastPaymentDate:formattedDate
          // DateTime.now().toIso8601String().split('T')[0],
        ));
      } else {
        print('Insufficient balance to pay');
      }
    }
  }
}
