import 'package:gatehub/services/end_points.dart';

class VehicleModel {
  final String plateNumber;
  final String modelCompany;
  final String color;
  final String type;
  final String licenseEnd;


  VehicleModel({
    required this.type, 
    required this.plateNumber,
    required this.modelCompany,
    required this.color,
    required this.licenseEnd,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> jsonData) {
    return VehicleModel(
      plateNumber: jsonData[ApiKey.plateNumber] ?? '',
      modelCompany: jsonData[ApiKey.modelCompany] ?? '',
      color: jsonData[ApiKey.color] ?? '',
      type: jsonData[ApiKey.type] ?? '',
       licenseEnd: jsonData[ApiKey.licenseEnd]?? ' '
      
      
    );
  }
}
