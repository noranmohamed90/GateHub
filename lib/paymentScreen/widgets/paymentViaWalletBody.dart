import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/bloc/cubit/payment_cubit.dart';
import 'package:gatehub/cubit/cubit/login_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Paymentviawalletbody extends StatefulWidget {
  final List<int> selectedFineIds;
 final double initialAmount;
  const Paymentviawalletbody({Key? key, required this.selectedFineIds, required this.initialAmount}) : super(key: key);

  @override
  State<Paymentviawalletbody> createState() => _PaymentviawalletbodyState();
}

class _PaymentviawalletbodyState extends State<Paymentviawalletbody> {
  @override
void initState() {
  super.initState();
    context.read<PaymentCubit>().amountController.text = 
        widget.initialAmount.toStringAsFixed(1); 
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F2F5),
        title: const Text(
          'Wallet Payment',
          style: TextStyle(color: kMainColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<PaymentCubit, PaymentState>(
        listener: (context, state) async {
           if (state is PaymentWalletSuccess) {
             print('Payment success detected');
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().toIso8601String();
    prefs.setString('lastPaymentDate', now);
    await context.read<LoginCubit>().getUserInfo();
    if (!mounted) return;
    await showDialog(
  context: context,
  barrierDismissible: true,
  builder: (context) => AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: Colors.green.shade100,
          radius: 50,
          child: Icon(
            Icons.check_circle,
            color: Colors.green.shade700,
            size: 80,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Success',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade700,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Your payment has been completed successfully.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    ),
    actionsAlignment: MainAxisAlignment.center,  
    actions: [
      SizedBox(
        width: 150,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700], 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), 
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Done',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  ),
);
  } else if (state is PaymentWalletFailure) {
              if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                children: [
                  const Text(
                    "Add the desired amount and proceed to payment using your wallet.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is GetUserInfoSuccess) {
                        final balance = state.user.balance.toStringAsFixed(1);
                        return SizedBox(
                          width: double.infinity,
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Current Balance",
                                    style: TextStyle(fontSize: 16, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "$balance EGP",
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: kMainColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else if (state is GetUserInfoLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const Text("Failed to load balance");
                      }
                    },
                  ),
                  const VerticalSpace(5),
                  TextField(
                    controller: context.read<PaymentCubit>().amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Enter amount in EGP",
                      labelStyle: const TextStyle(color: kMainColor),
                      prefixIcon: const Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: kMainColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: kMainColor, width: 2),
                      ),
                    ),
                  ),
                  const VerticalSpace(10),
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 55,
                      child: CustomeGeneralButton(
                        text: 'Confirm Payment',
                        onTap: () async {
                         await context.read<PaymentCubit>().walletPayment(widget.selectedFineIds);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}