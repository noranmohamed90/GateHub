import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/cubit/bloc/cubit/fines_cubit.dart';
import 'package:gatehub/paymentScreen/widgets/VisaBody.dart';
import 'package:gatehub/paymentScreen/widgets/paymentViaWalletBody.dart';

void PaymentBottomSheet(BuildContext context, List<int> selectedFineIds) {
  String selectedMethod = ""; 
  // ignore: unused_local_variable
  final finesCubit = context.read<FinesCubit>();
  final fines = context.read<FinesCubit>().finesList;
    final totalAmount = fines
      .where((fine) => selectedFineIds.contains(fine.id))
      .fold(0.0, (sum, fine) => sum + (fine.feeValue ?? 0) + (fine.fineValue ?? 0));

  showModalBottomSheet(
    backgroundColor: const Color(0xFFF0F2F5),
    context: context,
    isScrollControlled: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Choose Payment Method",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kMainColor),
                ),
                const SizedBox(height: 20),
                _buildPaymentOption(
                  label: "Wallet",
                  isSelected: selectedMethod == "wallet",
                  onTap: () {
                      Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Paymentviawalletbody(
                      selectedFineIds: selectedFineIds,
                      initialAmount: totalAmount, 
                    ),
                  ),
                );
              },
                ),
                const SizedBox(height: 12),
                _buildPaymentOption(
                  label: "Visa/MasterCard",
                  isSelected: selectedMethod == "visa",
                  onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Visabody(
                      selectedFineIds: selectedFineIds,
                      initialAmount: totalAmount, 
                    ),
                  ),
                );
              },
                ),
              ],
            ),
          );
        },
      );
    },
  );
}


Widget _buildPaymentOption({
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? kMainColor: Colors.grey.shade400,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? kMainColor : Colors.grey,
          ),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 16,color: kMainColor,fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

