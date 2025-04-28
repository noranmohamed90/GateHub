import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gatehub/cache/cache_helper.dart';
import 'package:gatehub/core/utiles/service_locator.dart';
import 'package:gatehub/services/api_consumer.dart';
import 'package:gatehub/services/end_points.dart';
import 'package:gatehub/services/errors/exception.dart';
import 'package:meta/meta.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.api) : super(OtpInitial());

  final ApiConsumer api;
   final TextEditingController passController = TextEditingController();
   final TextEditingController confirmPassController = TextEditingController();
   final TextEditingController otpController = TextEditingController();
   
 
 String ?email;
 void getEmail(){
  email= getIt<CacheHelper>().getData(key: 'email');
   if (email == null || email!.isEmpty) {
    emit(OtpFailure(errorMessage: "Email is missing"));
    return;
  }
  }
 

  String? validateOtp(){
    bool hasUppercase = passController.text.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = passController.text.contains(RegExp(r'[a-z]'));
    bool hasDigits = passController.text.contains(RegExp(r'\d'));
   // bool hasSpecialCharacters = passController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    
    if (otpController.text.isEmpty){
       return'Enter OTP code';
    } else if(otpController.text.length!=6 ){
      return'Incorrect OTP code, Try again';
    }
    if(passController.text.isEmpty){
      return 'New password is required';
    }else if(confirmPassController.text.isEmpty){
      return 'Please re-enter your password';
    }else if(passController.text!=confirmPassController.text){
        return'The passwords you entered do not match';
    }if (passController.text.length <=8 && hasDigits ) {
    return 'Password must have least one alphanumeric character.'; 
  } else if (passController.text.length <=10 && hasDigits && hasUppercase && hasLowercase) {
    return 'Passwords must have at least one non alphanumeric character.';
  }
  return null;
  }


verfiyOtp()async{
  getEmail();
   final validationMessage =validateOtp();
  if (validationMessage != null) {
    emit(OtpFailure(errorMessage: validationMessage));
    return;
  }
  
  emit(OtpLoading());
  try {

  final responce =await api.post(
    EndPoints.resetPassword,
    data: {
     'newPassword': passController.text,
     'confirmPassword': confirmPassController.text,
      'otp': otpController.text,
      'email':email
    } 
  );
  print(responce);
  emit(OtpSuccess());
} on ServerException catch (e) {
  emit(OtpFailure(errorMessage: e.errorModel.errorMessage));
}catch (e) {
    emit(OtpFailure(errorMessage: e.toString()));
  }
}
}

