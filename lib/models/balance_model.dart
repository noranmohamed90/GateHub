import 'package:gatehub/services/end_points.dart';

class BalanceModel {
   final double balance;
   final double pendingFees;
   final String lastPaymentDate;

  BalanceModel({required this.balance,
   required this.pendingFees, 
   required this.lastPaymentDate});


  factory BalanceModel.fromJson(Map<String, dynamic> jsonData) {
    return BalanceModel(
      balance: jsonData[ApiKey.balance], 
      pendingFees: jsonData['pending Fees']?? ' ', 
      lastPaymentDate: jsonData['lastPaymentDate']?? ''
      
    );
  } 
}