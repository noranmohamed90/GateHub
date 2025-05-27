import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/cubit/bloc/cubit/payment_cubit.dart';
import 'package:gatehub/cubit/cubit/login_cubit.dart';
import 'package:gatehub/paymentScreen/widgets/PaymentWebViewScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Visabody extends StatefulWidget {
  final List<int> selectedFineIds;
  final double initialAmount;

  const Visabody({Key? key, required this.selectedFineIds, required this.initialAmount}) : super(key: key);

  @override
  State<Visabody> createState() => _VisabodyState();
}

class _VisabodyState extends State<Visabody> {
   @override
  void initState() {
    super.initState();
     context.read<LoginCubit>().getUserInfo(); 
    context.read<PaymentCubit>().amountController.text = 
        widget.initialAmount.toStringAsFixed(1);
  }
  @override
  Widget build(BuildContext context) {
  
    // ignore: unused_local_variable
    final paymentCubit = context.read<PaymentCubit>();
    return Scaffold(
      backgroundColor: Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFF0F2F5),
        elevation: 0,
        title: const Text(
          'Pay with Card',
          style: TextStyle(
            color: kMainColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: kMainColor),
      ),
      body: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state)async {
          if (state is PaymentSuccess) {
             final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().toIso8601String();
    await prefs.setString('lastPaymentDate', now);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PaymentWebViewScreen(paymentUrl: state.paymentUrl),
         ),).then((_) {
          context.read<LoginCubit>().getUserInfo(); 
});
          } else if (state is PaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Text(
                'You will be redirected to a secure payment gateway.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.credit_card, color: kMainColor, size: 30),
                        SizedBox(width: 10),
                        Text(
                          'Visa / MasterCard',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: kMainColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: paymentCubit.amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter amount in EGP',
                        prefixIcon: const Icon(Icons.attach_money, color: kMainColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: kMainColor, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: 200,
                height: 55,   
                child: CustomeGeneralButton(
                  text: 'Confirm Payment',
                  onTap: () {
                    paymentCubit.visaPayment(widget.selectedFineIds); 
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}