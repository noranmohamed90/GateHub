import 'package:flutter/material.dart';
import '../models/fee.dart';

class FeeProvider with ChangeNotifier {
 final List<Fee> _fees = [
    Fee(title: "Pending fee", dueDate: "Jan 1, 2024", amount: 150.0),
    Fee(title: "Pending fee", dueDate: "Dec 22, 2024", amount: 150.0),
    Fee(title: "Pending fee", dueDate: "Jan 5, 2025", amount: 100.0),
  ];

  List<Fee> get fees => _fees;

  double get totalFees => _fees.fold(0, (sum, fee) => sum + fee.amount);

  double get selectedFees =>
      _fees.where((fee) => fee.isSelected).fold(0, (sum, fee) => sum + fee.amount);

  void toggleSelection(int index) {
    _fees[index].isSelected = !_fees[index].isSelected;
    notifyListeners();
  }

  void clearSelections() {
    for (var fee in _fees) {
      fee.isSelected = false;
    }
    notifyListeners();
  }
}
