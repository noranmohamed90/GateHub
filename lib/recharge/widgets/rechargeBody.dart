import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/cubit/login_cubit.dart';
import 'package:gatehub/cubit/cubit/recharge_cubit.dart';
import 'package:gatehub/recharge/rechargeWebView.dart';

class Rechargebody extends StatefulWidget {
  const Rechargebody({super.key});

  @override
  
  State<Rechargebody> createState() => _RechargebodyState();
}

class _RechargebodyState extends State<Rechargebody> {
  
  @override
  Widget build(BuildContext context) {
     // ignore: unused_local_variable
  final rechargeCubit = context.read<RechargeCubit>();
  return BlocListener<RechargeCubit, RechargeState>(
    listener: (context, state) {
      if (state is RechargeSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:  Text('Redirecting to payment...')),
        );
        Navigator.push(context, MaterialPageRoute(
        builder: (_) => Rechargewebview(paymentUrl: state.paymentUrl),
       ),).then((_) {
          context.read<LoginCubit>().getUserInfo(); 
});
      } else if (state is RechargeFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage)),
        );
      }
    },
    child: BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is GetUserInfoSuccess) {
          return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor:const Color(0xFFF0F2F5),
        title: const Text('Recharge',style: TextStyle(color: kMainColor,fontWeight: FontWeight.bold),),
         ),
         body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children:  [
             Card(
              color:  Colors.white,
              elevation: 2,
              child: Padding(
                padding:  EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Current Balance", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    SizedBox(height: 8),
                    Text( " ${state.user.balance.toStringAsFixed(2)} EGP",
                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: kMainColor)),
                  ],
                ),
              ),
            ),
              const VerticalSpace(3),
               TextField(
                controller:  context.read<RechargeCubit>().amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter amount",labelStyle: const TextStyle(color: kMainColor),
                prefixIcon:const  Icon(Icons.attach_money),
                border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(8),
               borderSide: const BorderSide(color: kMainColor),),
               focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:const BorderSide(color: kMainColor, width: 2),
    ),
              ),
            ),
            const VerticalSpace(3),
            DropdownButtonFormField(
              dropdownColor: Colors.white,
              items: const [
                DropdownMenuItem(child: Text("Visa / Mastercard"), value: "visa"),
              ],
               onChanged: (value) {},
              decoration: InputDecoration(
                labelText: "Payment Method",labelStyle: const TextStyle(color: kMainColor),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: kMainColor),
                ),
                focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:const  BorderSide(color: kMainColor, width: 2),
    ),),
                    
            ),
            const VerticalSpace(10),
             Center(
               child: SizedBox(
                width: 220,
                height: 55,
                 child: CustomeGeneralButton(
                  text: 'Recharge Now',
                  onTap: () {
                      context.read<RechargeCubit>().rechargebalance();
                  },
                 )),
                             ),
              ] ),
             )
        
        );
  }
   else if (state is GetUserInfoLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is GetUserInfoFailure) {
      return Center(child: Text("Error: ${state.errorMessage}"));
    } else {
      return const Center(child: Text("Loading user data..."));
    }
}));}
}