import 'package:flutter/material.dart';
import 'package:gatehub/Payment/widgets/payment_screen.dart';

class Paymentview extends StatelessWidget {
  const Paymentview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaymentScreen(),
      );
  }
}