import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:gatehub/services/api_consumer.dart';
import 'package:gatehub/services/end_points.dart';
import 'package:gatehub/services/errors/exception.dart';
import 'package:meta/meta.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.api) : super(PaymentInitial());
  final ApiConsumer api;
  List<int> vehicleEntryIds = [];
 
  final TextEditingController amountController = TextEditingController();
   String?validateData(){
    if(amountController.text.isEmpty){
      return'Please Enter The amount you want to recharge';
    }  return null;
  }

visaPayment(List<int> selectedFineIds)async{
final validationMessage =validateData();
  if (validationMessage != null) {
    emit(PaymentFailure(errorMessage: validationMessage));
    return;
  }
  emit(PaymentLoading());
 try {
  final response =await api.post(
   EndPoints.visaPayment,
   data: selectedFineIds,
  );
  print(response);
  print(selectedFineIds.runtimeType);  
  print(selectedFineIds);
   final paymentUrl = response['paymentUrl'];
    if (paymentUrl != null) {
      emit(PaymentSuccess(paymentUrl: paymentUrl));  
    } else {
      emit(PaymentFailure(errorMessage: "No payment URL received"));
    }
} on ServerException catch (e) {
  emit(PaymentFailure(errorMessage: e.errorModel.errorMessage));
}
}

walletPayment(List<int> selectedFineIds)async{
  emit(PaymentWalletLoading());
 try {
  final response =await api.post(
   EndPoints.walletPayment,
   data: selectedFineIds,
  );
   print('Wallet Payment Response: $response');

    if (response['message'] == 'Payment successful') {
      emit(PaymentWalletSuccess());
    } else {
      final errorMsg = response['message'] ?? 'Payment failed';
      emit(PaymentWalletFailure(errorMessage: errorMsg));
    }
} on ServerException catch (e) {
  emit(PaymentWalletFailure(errorMessage: e.errorModel.errorMessage));
}
}  
}
