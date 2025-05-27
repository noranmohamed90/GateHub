import 'package:gatehub/services/end_points.dart';

class Changepass {
final String currentPassword;
final String newPassword;
final String confirmPassword;

  Changepass({
   required this.currentPassword,
   required this.newPassword,
   required this.confirmPassword});


     factory Changepass.fromJson(Map<String, dynamic> jsonData) {
    return Changepass(
      currentPassword: jsonData[ApiKey.currentPassword],
      newPassword: jsonData[ApiKey.newPassword],
      confirmPassword: jsonData[ApiKey.confirmPassword]
     
      
    );
  } 

}