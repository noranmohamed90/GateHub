import 'package:flutter/material.dart';

class RechargeScreen extends StatefulWidget {
  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeede9),
      appBar: AppBar(
        title: Text("Recharge",
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico')),
        backgroundColor: Color(0xffeeede9),
        foregroundColor: Color(0xff1a354a),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff1a354a),
            size: 35,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Center(
                child: ClipOval(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset('assets/images/money.png',
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Amount",
                  labelStyle: TextStyle(
                      color: Color(0xff1a354a),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  floatingLabelStyle: TextStyle(
                    color: Color(0xff1a354a),
                    fontSize: 20,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                      child: Text("Credit Card"), value: "Credit Card"),
                  DropdownMenuItem(
                      child: Text("Vodafone Cash"), value: "Vodafone Cash")
                ],
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Payment Method",
                  labelStyle: TextStyle(
                    color: Color(0xff1a354a),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(250, 50),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  String amount = amountController.text.trim();
                  if (amount.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Recharged: \$${amount}")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please enter an amount")),
                    );
                  }
                },
                child: const Text(
                  "Recharge",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1a354a),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
