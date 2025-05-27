import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:gatehub/cache/cache_helper.dart';
import 'package:gatehub/core/utiles/service_locator.dart';
import 'package:gatehub/services/api_consumer.dart';
import 'package:gatehub/services/end_points.dart';
import 'package:gatehub/services/errors/exception.dart';
import 'package:meta/meta.dart';

part 'recharge_state.dart';

class RechargeCubit extends Cubit<RechargeState> {
  RechargeCubit(this.api) : super(RechargeInitial());
    final ApiConsumer api;
  final TextEditingController amountController = TextEditingController();
   String?validateData(){
    if(amountController.text.isEmpty){
      return'Please Enter The amount you want to recharge';
    }  return null;
  }

rechargebalance()async{
       final validationMessage =validateData();
  if (validationMessage != null) {
    emit(RechargeFailure(errorMessage: validationMessage));
    return;
  }
  emit(RechargeLoading());
 try {
  final response =await api.post(
   EndPoints.recharge, 
   data: {
   'amount':amountController.text
   }
  );
  print(response);
   getIt<CacheHelper>().saveData(key: 'id', value: ApiKey.id);
   final paymentUrl = response['paymentUrl'];
    if (paymentUrl != null) {
      emit(RechargeSuccess(paymentUrl: paymentUrl));  
    } else {
      emit(RechargeFailure(errorMessage: "No payment URL received"));
    }
} on ServerException catch (e) {
  emit(RechargeFailure(errorMessage: e.errorModel.errorMessage));
}
}
}
