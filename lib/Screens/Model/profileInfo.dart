class Profileinfo {
  final String userName;
  final String nationalId;
  final String phoneNumber;
  final List <VehicleDetails> vehicle;
  //final List <TransactionModel> transactionModel;

  Profileinfo({required this.userName,
   required this.nationalId, 
   required this.phoneNumber,
   required this.vehicle,
  // required this.transactionModel 
   });
}

class VehicleDetails {
  final String model;
  final String plateNumber;
  final String color;

  VehicleDetails({
    required this.model,
    required this.plateNumber,
    required this.color,
  });
}


// class TransactionModel {
//   final String amount;
//   final String date;

//   TransactionModel({required this.amount, required this.date});
// }
