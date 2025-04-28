import 'package:gatehub/services/end_points.dart';

class TransactionModel {
  final String paymentType;
  final double amount;
  final String transactionDate;
  final String status;

  TransactionModel({
    required this.paymentType,
     required this.amount, 
     required this.transactionDate, 
     required this.status});

   factory TransactionModel.fromJson(Map<String,dynamic>jsonData){
    return TransactionModel(
      paymentType: jsonData[ApiKey.paymentType] ?? '',
       amount: jsonData[ApiKey.amount], 
       transactionDate: jsonData[ApiKey.transactionDate], 
       status: jsonData[ApiKey.status]
       );
   }


}