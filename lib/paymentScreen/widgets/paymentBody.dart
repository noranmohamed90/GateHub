import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/bottomSheet.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/bloc/cubit/fines_cubit.dart';
import 'package:gatehub/cubit/cubit/login_cubit.dart';
import 'package:gatehub/models/finesModel.dart';
import 'package:gatehub/paymentScreen/widgets/objectionBody.dart';
import 'package:intl/intl.dart';


class FinesScreen extends StatelessWidget {
  const FinesScreen({super.key});

 double getTotalFines(List<Finesmodel> fines) =>
    fines.fold(0, (sum, fine) => sum + ((fine.feeValue ?? 0) + (fine.fineValue ?? 0)));
  double getSelectedFines(List<Finesmodel> fines) =>
    fines
        .where((f) => f.selected == true)
        .fold(0, (sum, fine) => sum + ((fine.feeValue ?? 0) + (fine.fineValue ?? 0)));       
  String _formatDateTime(String? rawDate) {
  if (rawDate == null) return 'Unknown';
  try {
    final dateTime = DateTime.parse(rawDate);
    final formattedTime = DateFormat.Hm().format(dateTime); 
    final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime); 
    return '$formattedDate - $formattedTime';
  } catch (e) {
    return rawDate; 
  }
  
  
}    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text('Fines and Fees', style: TextStyle(color: kMainColor,fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFF0F2F5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                double balance = 0;
                if (state is GetUserInfoSuccess) {
                  balance = state.user.balance;
                }
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  color: const Color(0xFFE2E8EB),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.account_balance_wallet, color: kMainColor),
                        const SizedBox(width: 10),
                        const Text("Balance: ",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const Spacer(),
                        Text("${balance.toStringAsFixed(1)} EGP",
                            style: TextStyle(fontSize: 16, color: Colors.green[700])),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<FinesCubit, FinesState>(
                builder: (context, state) {
                  if (state is GetFinesInfoSuccess) {
                    final fines = state.fines;

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: fines.length,
                            itemBuilder: (context, index) {
                              final fine = fines[index];
                              return Card(
                                color: Colors.white,
                                elevation: 2,
                                margin: const EdgeInsets.only(bottom: 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
                                  leading: Checkbox(
                                    value: fine.selected,
                                    onChanged: (value) {
                                           context.read<FinesCubit>().updateFineSelection(index, value);
                                    },
                                  ),
                                  title: Text('${fine.fineType}' , style: const TextStyle(fontWeight: FontWeight.bold)),
                                 subtitle: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      children: [
        Text("Gate: ${fine.gateName}"),
        const HorizintalSpace(5),
      ],
    ),
    VerticalSpace(.003),
    Row(
      children: [
        
        const Text("Fines and Fees: ", style: TextStyle()),
        Text("${((fine.feeValue ?? 0) + (fine.fineValue ?? 0)).toStringAsFixed(1)} EGP"),
       
      ],
    ),
    Row(
      children: [
        const Text("Date: ", style: TextStyle()),
        Text(_formatDateTime(fine.date)),
        
      ],
    ),
  ],
),
                                  
                                  isThreeLine: true,
                                  trailing: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => Objectionbody(vehicleEntryId: fine.id!)));
                                    },
                                    child: const Text("Object", style: TextStyle(color: kMainColor)),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSmallInfoBox("Total Fines", getTotalFines(fines)),
                            _buildSmallInfoBox("Selected", getSelectedFines(fines)),
                            
                          ],
                        ),
                      ],
                    );
                  } else if (state is GetFinesInfoFailure) {
                    return Center(child: Text(state.errorMessage));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<FinesCubit, FinesState>(
          builder: (context, state) {
            if (state is GetFinesInfoSuccess) {
              final selectedFines = state.fines.where((fine) => fine.selected == true).toList();
              return ElevatedButton.icon(
                onPressed: ()  {
    if (selectedFines.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please select fines to pay")));
    } else {
      final selectedFineIds = selectedFines.map((f) => f.id!).toList();
      
      PaymentBottomSheet(context, selectedFineIds);
    }
  },
                
                icon: const Icon(Icons.payment, color: Colors.white),
                label: const Text("Pay Selected Fines", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: kMainColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSmallInfoBox(String title, double value) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8EB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kMainColor),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text("${value.toStringAsFixed(1)} EGP", style: const TextStyle(fontSize: 14, color: Colors.black87)),
        ],
      ),
    );
  }
}
