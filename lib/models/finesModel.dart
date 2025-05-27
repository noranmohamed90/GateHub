class Finesmodel {
  final int? id;
  final String? fineType;
  final double? fineValue;
  final double? feeValue;
  final String? gateName;
  final String? date;
  bool selected; 
   final String? vehicleEntryId;

  Finesmodel({
    this.id,
    this.fineType,
    this.fineValue,
    this.feeValue,
    this.gateName,
    this.date,
    this.selected = false, 
    this.vehicleEntryId
  });

  factory Finesmodel.fromJson(Map<String, dynamic> json) {
    return Finesmodel(
      id: json['id'],
      fineType: json['fineType'],
      fineValue: (json['fineValue'] as num?)?.toDouble(),
      feeValue: (json['feeValue'] as num?)?.toDouble(),
      gateName: json['gateName'],
      date: json['date'],
      selected: false, 
      vehicleEntryId: json['vehicleEntryId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fineType': fineType,
      'fineValue': fineValue,
      'feeValue': feeValue,
      'gateName': gateName,
      'date': date,
      'vehicleEntryId':vehicleEntryId
    };
  }

  Finesmodel copyWith({
    int? id,
    String? fineType,
    double? fineValue,
    double? feeValue,
    String? gateName,
    String? date,
    bool? selected,
    String? vehicleEntryId,

  }) {
    return Finesmodel(
      id: id ?? this.id,
      fineType: fineType ?? this.fineType,
      fineValue: fineValue ?? this.fineValue,
      feeValue: feeValue ?? this.feeValue,
      gateName: gateName ?? this.gateName,
      date: date ?? this.date,
      selected: selected ?? this.selected,
      vehicleEntryId : vehicleEntryId ??this.vehicleEntryId
    );
  }
}
