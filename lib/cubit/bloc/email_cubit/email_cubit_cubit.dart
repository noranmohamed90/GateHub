import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gatehub/cache/cache_helper.dart';
import 'package:gatehub/core/utiles/service_locator.dart';
import 'package:gatehub/models/login_model.dart';

import 'package:gatehub/services/api_consumer.dart';
import 'package:gatehub/services/end_points.dart';
import 'package:gatehub/services/errors/exception.dart';
part 'email_cubit_state.dart';



class EmailCubitCubit extends Cubit<EmailCubitState> {
  EmailCubitCubit(this.api) : super(EmailCubitInitial());
  final ApiConsumer api;


 final TextEditingController emailController =TextEditingController(); 

 String? validateInput() {
    if (emailController.text.isEmpty) {
      return 'please Enter your email';
    }
     return null;
  } 
 LoginModel?user;
emailValidation() async {
   final validationMessage = validateInput();
  if (validationMessage != null) {
    emit(EmailFailure(errorMessage: validationMessage));
    return;
  }
  emit(EmailLoading());
  try {
    final response = await api.post(
      EndPoints.requestOtp,
      data: {
        ApiKey.email: emailController.text,
      },
    );
      getIt<CacheHelper>().saveData(key: 'email', value: emailController.text);
        print(response);
    emit(EmailSuccess());

  } on ServerException catch (e) {
    emit(EmailFailure(errorMessage: e.errorModel.errorMessage));
  } catch (e) {
    emit(EmailFailure(errorMessage: e.toString()));
  }
}
}

