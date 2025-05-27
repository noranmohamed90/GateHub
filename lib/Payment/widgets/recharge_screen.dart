
 import 'package:flutter/material.dart';
import 'package:gatehub/services/payment_service.dart';

class RechargeScreen extends StatefulWidget {
  final double? selectedAmount;
  final VoidCallback? onPayFromBalance;


  const RechargeScreen({
    super.key,
    this.selectedAmount,
    this.onPayFromBalance,
  });

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}
class _RechargeScreenState extends State<RechargeScreen> {
  final TextEditingController _amountController = TextEditingController();
  final PaymentService _paymentService = PaymentService();
  String? _selectedPaymentMethod;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedAmount != null) {
      _amountController.text = widget.selectedAmount!.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _handlePayment() async {
    if (_isProcessing) return;

    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter an amount")),
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid amount")),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      bool success;
      if (widget.onPayFromBalance != null && _selectedPaymentMethod == null) {
        widget.onPayFromBalance!();
        success = true;
      } else if (_selectedPaymentMethod != null) {
        success = await _paymentService.rechargeBalance(amount: amount);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select a payment method")),
        );
        return;
      }

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Payment successful: ${amount.toStringAsFixed(2)} LE")),
        );
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeede9),
      appBar: AppBar(
        title: const Text(
          "Recharge",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
          ),
        ),
        backgroundColor: const Color(0xffeeede9),
        foregroundColor: const Color(0xff1a354a),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff1a354a),
            size: 35,
          ),
          onPressed: _isProcessing ? null : () => Navigator.pop(context),
        ),
      ),
      body: _isProcessing
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: ClipOval(
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: Image.asset(
                            'assets/images/money.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Amount",
                        labelStyle: const TextStyle(
                          color: Color(0xff1a354a),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Color(0xff1a354a),
                          fontSize: 20,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedPaymentMethod,
                      items: const [
                        DropdownMenuItem(
                          value: "Credit Card",
                          child: Text("Credit Card"),
                        ),
                        DropdownMenuItem(
                          value: "Vodafone Cash",
                          child: Text("Vodafone Cash"),
                        ),
                      ],
                      onChanged: _isProcessing
                          ? null
                          : (value) => setState(() => _selectedPaymentMethod = value),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Payment Method",
                        labelStyle: TextStyle(
                          color: Color(0xff1a354a),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(250, 50),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: const Color(0xff1a354a),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _isProcessing ? null : _handlePayment,
                      child: _isProcessing
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Confirm",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    if (widget.onPayFromBalance != null) ...[
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(250, 50),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: const Color(0xff1a354a),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _isProcessing ? null : _handlePayment,
                        child: _isProcessing
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                "Pay from Balance",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}