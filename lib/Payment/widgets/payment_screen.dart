import 'package:flutter/material.dart';
import 'package:gatehub/payment/provider/fee_provider.dart';
import 'package:gatehub/payment/widgets/recharge_screen.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeeProvider>(context, listen: false).loadFees();
    });
  }

  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xffeeede9),
      appBar: AppBar(
        title: const Text(
          "Payment Page",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
          ),
        ),
        backgroundColor: const Color(0xffeeede9),
        foregroundColor: const Color(0xff1a354a),
        elevation: 0,
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back, size: 35),
                onPressed: () => Navigator.of(context).maybePop(),
              )
            : null,
      ),
      body: _buildBody(feeProvider),
    );
  }

  Widget _buildBody(FeeProvider feeProvider) {
    if (feeProvider.isLoading && feeProvider.fees.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (feeProvider.errorMessage != null) {
      return Center(child: Text(feeProvider.errorMessage!));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Fees and Fines",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1a354a),
                ),
              ),
              GestureDetector(
                onTap: feeProvider.isLoading ? null : () => feeProvider.clearSelections(),
                child: const Text(
                  "Clear All",
                  style: TextStyle(
                    color: Color.fromARGB(255, 146, 21, 12),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(child: _buildFeesList(feeProvider)),
          _buildPaymentSection(feeProvider),
        ],
      ),
    );
  }

  Widget _buildFeesList(FeeProvider feeProvider) {
    if (feeProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: feeProvider.fees.length,
      itemBuilder: (context, index) {
        final fee = feeProvider.fees[index];
        return ListTile(
          leading: Checkbox(
            value: fee.isSelected,
            onChanged: feeProvider.isLoading
                ? null
                : (_) => feeProvider.toggleSelection(index),
          ),
          title: Text(
            fee.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff1a354a),
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            "Due ${fee.dueDate}",
            style: const TextStyle(
              color: Color(0xff1a354a),
              fontSize: 15,
            ),
          ),
          trailing: Text(
            "${fee.amount.toStringAsFixed(1)} LE",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff1a354a),
              fontSize: 15,
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentSection(FeeProvider feeProvider) {
    return Column(
      children: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Fees:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff1a354a),
              ),
            ),
            Text(
              "${feeProvider.totalFees.toStringAsFixed(1)} LE",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff1a354a),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total Selected Fees:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff1a354a),
              ),
            ),
            Text(
              "${feeProvider.selectedFees.toStringAsFixed(1)} LE",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff1a354a),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: feeProvider.selectedFees > 0 && !feeProvider.isLoading
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RechargeScreen(
                        selectedAmount: feeProvider.selectedFees,
                        onPayFromBalance: () async {
                          try {
                            final success = await feeProvider.paySelectedFees();
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Payment successful!")),
                              );
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error: ${e.toString()}")),
                            );
                          }
                        },
                      ),
                    ),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: const Color(0xff1a354a),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Make Payment",
            style: TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: !feeProvider.isLoading 
              ? () {
                  _showObjectionDialog(context, feeProvider);
                }
              : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: const Color(0xff1a354a),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            "Make An Objection",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  void _showObjectionDialog(BuildContext context, FeeProvider feeProvider) {
    final objectionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Submit Objection"),
          content: TextField(
            controller: objectionController,
            decoration: const InputDecoration(
              hintText: "Enter your objection reason",
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (objectionController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter objection text")),
                  );
                  return;
                }
                
                try {
                  final success = await feeProvider.submitObjection(
                    objectionController.text.trim(),
                  );
                  
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Objection submitted successfully!")),
                    );
                    Navigator.pop(context);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${e.toString()}")),
                  );
                }
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}