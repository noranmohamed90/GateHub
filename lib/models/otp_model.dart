import 'package:gatehub/services/end_points.dart';

class OtpModel {
final String email;
final String otp;
final String newPassword;
final String confirmPassword;

  OtpModel({required this.email,
   required this.otp, 
   required this.newPassword,
    required this.confirmPassword});


     factory OtpModel.fromJson(Map<String, dynamic> jsonData) {
    return OtpModel(
      email: jsonData[ApiKey.email],
      otp: jsonData[ApiKey.otp],
      newPassword: jsonData[ApiKey.newPassword],
      confirmPassword: jsonData[ApiKey.confirmPassword]
     
      
    );
  } 

}