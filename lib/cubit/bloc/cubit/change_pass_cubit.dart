import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gatehub/services/api_consumer.dart';
import 'package:gatehub/services/end_points.dart';
import 'package:gatehub/services/errors/exception.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'change_pass_state.dart';

class ChangePassCubit extends Cubit<ChangePassState> {
  ChangePassCubit(this.api) : super(ChangePassInitial());
  final ApiConsumer api;
  final TextEditingController currentpassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();

  String?validateData(){
    if(currentpassController.text.isEmpty){
      return'Please Enter your Current Password';
    }else if(newPassController.text.isEmpty){
      return 'create new Password';
    }else if(confirmPassController.text.isEmpty){
      return 'Confirm Your Password';
    }else if(newPassController.text != confirmPassController.text){
      return 'The passwords you entered do not match';
    }else if(newPassController.text == currentpassController.text){
      return 'You must Choose New Password';
    }
      return null;
  }
  changePass()async{
      final validationMessage =validateData();
  if (validationMessage != null) {
    emit(ChangePassFailure(errorMessage: validationMessage));
    return;
  }
   emit(ChangePassLoading());
   try {
  final response = await api.post(
   EndPoints.changePassword,
   data: {
    'currentPassword':currentpassController.text,
    'newPassword':newPassController.text,
    'confirmPassword':confirmPassController.text
   }

  ); print(response);
  emit(ChangePassSuccess());
} on ServerException catch (e) {
  final errorMsg = e.errorModel.errorMessage.toLowerCase();

  if (errorMsg.contains('incorrect password')) {
    emit(ChangePassFailure(errorMessage: 'The current password is incorrect.'));
  } else {
    emit(ChangePassFailure(errorMessage: e.errorModel.errorMessage));
  } 
  }
} 
logOut()async{
  emit(LogOutLoading());
  try {
  final response= await api.post(
    EndPoints.logout
  );
  print(response);
   final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 
  emit(LogOutSuccess());
}  on ServerException catch (e) {
    emit(LogOutFailure(errorMessage: e.errorModel.errorMessage));
  } catch (e) {
    emit(LogOutFailure(errorMessage: e.toString()));
  }
}
}

