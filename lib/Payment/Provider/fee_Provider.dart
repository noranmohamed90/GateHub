
import 'package:flutter/material.dart';
import 'package:gatehub/payment/Models/fee.dart';
import 'package:gatehub/services/payment_service.dart';

class FeeProvider with ChangeNotifier {
  final PaymentService _paymentService = PaymentService();
  List<Fee> _fees = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Fee> get fees => _fees;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  double get totalFees => _fees.fold(0, (sum, fee) => sum + fee.amount);
  double get selectedFees => _fees.where((fee) => fee.isSelected).fold(0, (sum, fee) => sum + fee.amount);

  Future<void> loadFees() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      
      await Future.delayed(const Duration(seconds: 1)); 
      
      _fees = [
        Fee(id: "1", title: "Pending fee", dueDate: "Jan 1, 2024", amount: 150.0),
        Fee(id: "2", title: "Pending fee", dueDate: "Dec 22, 2024", amount: 150.0),
        Fee(id: "3", title: "Pending fee", dueDate: "Jan 5, 2025", amount: 100.0),
      ];
    } catch (e) {
      _errorMessage = "Failed to load fees: ${e.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

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

  Future<bool> paySelectedFees() async {
    if (_isLoading) return false;
    
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final selectedIds = _fees
          .where((fee) => fee.isSelected)
          .map((fee) => fee.id)
          .toList();
      
      if (selectedIds.isEmpty) return false;
      
      bool success;
      if (selectedIds.length == 1) {
        success = await _paymentService.payVehicleEntry(entryId: selectedIds.first);
      } else {
        success = await _paymentService.payMultipleVehicleEntries(entryIds: selectedIds);
      }
      
      if (success) {
        await loadFees(); 
      }
      return success;
    } catch (e) {
      _errorMessage = "Payment failed: ${e.toString()}";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> submitObjection(String objectionText) async {
    if (_isLoading) return false;
    
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    
    try {
      final selectedFees = _fees.where((fee) => fee.isSelected).toList();
      if (selectedFees.isEmpty) return false;
      
      return await _paymentService.submitObjection(
        objectionText: objectionText,
        feeIds: selectedFees.map((fee) => fee.id).toList(),
      );
    } catch (e) {
      _errorMessage = "Submission failed: ${e.toString()}";
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
