import 'package:gatehub/cache/cache_helper.dart';
import 'package:gatehub/core/utiles/service_locator.dart';
import 'package:gatehub/models/transaction_model.dart';
import 'package:gatehub/models/vehicle_model.dart';
import 'package:gatehub/services/end_points.dart';

class UserInfo {
  final String name;
  final String natId;
  final String phoneNumber;
  final double balance;
  final String licenseEnd;
  final String address;
  final List<VehicleModel> vehicles;
  final List<TransactionModel> transactions;
  
  

  UserInfo({ 
    required this.transactions, 
    required this.name, 
    required this.natId,
    required this.phoneNumber,
    required this.balance, 
    required this.licenseEnd,
    required this.address,
    required this.vehicles
     
     });
     factory UserInfo.fromJson(Map<String, dynamic> jsonData) {
     final vehicle = (jsonData['vehicles'] as List).isNotEmpty
      ? jsonData['vehicles'][0]
      : {};

  return UserInfo(
    name: getIt<CacheHelper>().getData(key: 'name') ?? '',
    natId: getIt<CacheHelper>().getData(key: 'natId') ?? '',
    phoneNumber: jsonData[ApiKey.phoneNumber] ?? '',
    balance: (jsonData[ApiKey.balance] as num?)?.toDouble() ?? 0.0,
    licenseEnd: vehicle[ApiKey.licenseEnd] ?? '',
    address: jsonData[ApiKey.address] ?? '',
     vehicles: (jsonData['vehicles'] as List)
          .map((vehicleJson) => VehicleModel.fromJson(vehicleJson))
          .toList(),
    transactions: (jsonData['transactions'] as List)
    .map((transactionJson) => TransactionModel.fromJson(transactionJson))
    .toList() ,      
               
    
  );
  
}
}
