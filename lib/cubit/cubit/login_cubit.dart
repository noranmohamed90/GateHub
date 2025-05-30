 import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gatehub/cache/cache_helper.dart';
import 'package:gatehub/core/utiles/service_locator.dart';
import 'package:gatehub/models/login_model.dart';
import 'package:gatehub/models/user_info.dart';
import 'package:gatehub/services/api_consumer.dart';
import 'package:gatehub/services/end_points.dart';
import 'package:gatehub/services/errors/exception.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.api,) : super(LoginInitial());  
  final ApiConsumer api;  
  final TextEditingController natIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String?deviceToken;
  Future<void> getDeviceToken() async {
  await FirebaseMessaging.instance.requestPermission(); 
  deviceToken = await FirebaseMessaging.instance.getToken();
  print("Device Token in LoginCubit: $deviceToken");
}
  
  String? validateInput() {
    if (natIdController.text.isEmpty || passwordController.text.isEmpty) {
      return 'Both fields are required.';
    } else if (natIdController.text.length != 14) {
      return 'National ID must be exactly 14 digits.';
    }
    return null;
  }
 LoginModel?user;
  loginUser()async{
    final validationMessage = validateInput();
    if (validationMessage != null) {
      emit(LoginFailure(errorMessage: validationMessage));
      return;
    
    }
    try {
      emit(LoginLoading());
    final response =await api.post(
      EndPoints.login,
      data: {
      ApiKey.natId : natIdController.text,
      ApiKey.password : passwordController.text,
      ApiKey.rememberMe:true,
      ApiKey.deviceToken:deviceToken,
      
  });
      user=LoginModel.fromJson(response);
    final decodeToken =   JwtDecoder.decode(user!.token); 
     print(decodeToken['id']);
     getIt<CacheHelper>().saveData(key: ApiKey.token,value: user!.token);
     getIt<CacheHelper>().saveData(key: ApiKey.id,value:  user!.id);
     getIt<CacheHelper>().saveData(key: 'name', value: user!.name);
     getIt<CacheHelper>().saveData(key: 'natId', value: natIdController.text);
     getIt<CacheHelper>().saveData(key: ApiKey.deviceToken, value: user!.deviceToken);
    print("User ID: ${user!.id}");
    print("User email: ${user!.email}");
    print("deviceToken: ${user!.deviceToken}");
    print("TOKEN USED: ${user!.token}");

  emit(LoginSuccess());
} on ServerException catch (e) {
  emit(LoginFailure(errorMessage: e.errorModel.errorMessage));
}}

 UserInfo?userInfo;
getUserInfo ()async{
  try {
    emit(GetUserInfoLoading());
  final response =await api.get(
      EndPoints.voProfile);
      emit(GetUserInfoSuccess(user: UserInfo.fromJson(response)));
} on ServerException catch (e) {
   emit(GetUserInfoFailure(errorMessage: e.errorModel.errorMessage));
}
}
void checkIfUserLoggedIn() async {
  final token = await getIt<CacheHelper>().getData(key: ApiKey.token);
  if (token != null) {
    emit(LoginSuccess());  
    getUserInfo();  
  } else {
    emit(LoginInitial());
  }
}

}

