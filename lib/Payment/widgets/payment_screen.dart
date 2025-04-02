import 'package:flutter/material.dart';
import 'package:gatehub/Payment/Provider/fee_Provider.dart';
import 'package:gatehub/Payment/widgets/recharge_screen.dart';
import 'package:provider/provider.dart';

import '../models/fee.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xffeeede9),
      appBar: AppBar(
        title: const Text("Payment Page",
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico')),
        backgroundColor: Color(0xffeeede9),
        foregroundColor: Color(0xff1a354a),
        elevation: 0,
        leading: Navigator.of(context).canPop() ?
        IconButton(icon:Icon(Icons.arrow_back,size: 35,),
        onPressed: ()=>Navigator.of(context).maybePop()):null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Fees and Fines",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1a354a))),
                GestureDetector(
                  onTap: () => feeProvider.clearSelections(),
                  child: const Text("Clear All",
                      style: TextStyle(
                          color: Color.fromARGB(255, 146, 21, 12),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: feeProvider.fees.length,
                itemBuilder: (context, index) {
                  Fee fee = feeProvider.fees[index];
                  return ListTile(
                    leading: Checkbox(
                      value: fee.isSelected,
                      onChanged: (_) => feeProvider.toggleSelection(index),
                    ),
                    title: Text(fee.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1a354a),
                            fontSize: 18)),
                    subtitle: Text("Due ${fee.dueDate}",
                        style: const TextStyle(
                            color: Color(0xff1a354a), fontSize: 15)),
                    trailing: Text("${fee.amount.toStringAsFixed(1)} LE",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1a354a),
                            fontSize: 15)),
                  );
                },
              ),
            ),
            
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Fees:",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1a354a))),
                Text("${feeProvider.totalFees.toStringAsFixed(1)} LE",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1a354a))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Selected Fees:",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1a354a))),
                Text("${feeProvider.selectedFees.toStringAsFixed(1)} LE",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1a354a))),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: feeProvider.selectedFees > 0
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RechargeScreen()),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Color(0xff1a354a),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                "Make Payment",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Color(0xff1a354a),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                "Make An Objection",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
