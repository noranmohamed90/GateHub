//import 'dart:convert';

import 'package:gatehub/services/end_points.dart';

class LoginModel {
  final String name;
  final String natId;
  final String phoneNumber;
  final String token;
  final String id;
  final String email;

  

  LoginModel({required this.id,required this.name, required this.natId, required this.phoneNumber, required this.token,required this.email});

  factory LoginModel.fromJson(Map<String,dynamic>jsonData){
   final userData = jsonData['user'];
  //final tokenData = jsonData['token'];
  final tokenResult = jsonData['tokenString']['result'];

  print(jsonData);

  return LoginModel(
    id:userData[ApiKey.id],
    name: userData[ApiKey.name],
    natId: userData[ApiKey.natId],
    phoneNumber: userData[ApiKey.phoneNumber],
    email: userData[ApiKey.email],
    token: tokenResult
    
  );
  
  }
}