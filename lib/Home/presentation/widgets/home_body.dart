import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/Home/Model/homeInfo.dart';
import 'package:gatehub/Home/presentation/widgets/notifications.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/utiles/size_config.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/balance_cubit.dart';
import 'package:gatehub/cubit/balance_states.dart';
import 'package:gatehub/cubit/notifications_cubit.dart';
import 'package:gatehub/cubit/notifications_states.dart';

class HomeBody extends StatelessWidget {
   HomeBody({super.key});

  final Homeinfo userInfo = Homeinfo(
    userName: 'Ahmed',
    //  balance: 500, 
    // pendingFees: 150, 
    // lastPaymentDate: '25 Dec ',
     licenseExpirationDate: '5 jan 2025');

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          BlocBuilder<NotificationCubit,NotificationState> (
            builder: (context,state){
             int unreadCount =0;
             if(state is NotificationUpdated){
                unreadCount = state.unreadNotifications;
               }
            return Stack(
              children:[ IconButton(
                icon:const  Icon(Icons.notifications),
             color: kMainColor,
                onPressed: (){
              context.read<NotificationCubit>().readNotifications();
              Navigator.push(context,
                 MaterialPageRoute(builder: (context) => Notifications()),
);   }, 
          ),if(unreadCount >0)
          Positioned(
            top: 8,
            right: 8,
            child: Container(
               padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),child: Text(
                unreadCount.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              ))
          ]   );

  })], ),
          
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child:  SizedBox(
                  height: SizeConfig.defualtSize!*12,
                  width: SizeConfig.defualtSize!*12,
                  child: const  CircleAvatar(
                    backgroundImage: 
                    AssetImage('assets/images/logo.png'),
                     backgroundColor: kMainColor,
                    ))),
                    const VerticalSpace(2),
                    Text(userInfo.userName,
                    style: const TextStyle(
                      color: kMainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                    ),),
                    BlocBuilder<BalanceCubit,BalanceState>(
                      builder: (context, state){
                        if (state is UpdateBalanceState){
                      return  Column(
                        children: [
                     Text(" Your Balance is ${state.balance} LE",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15
                    ),),
                   const  VerticalSpace(8),
                      Padding(
                       padding: const  EdgeInsets.all(30.0),
                       child: Row(
                         children: [
                            const Text("Pending Fees",
                            style: TextStyle(
                            color: kMainColor,
                            fontSize: 18),),
                            const HorizintalSpace(12),
                            Text("${state.pendingFees} LE",
                            style:const  TextStyle(
                            color: kMainColor,
                            fontSize: 18),)] ) ),
                            const Divider(
                              color: Colors.grey,
                              indent: 55,
                              endIndent:60,
                            ), 
                            Padding(
                       padding:  const EdgeInsets.all(30.0),
                       child:
                        Row(
                         children: [
                            const Text("Last Payment date",
                            style: TextStyle(
                            color: kMainColor,
                            fontSize: 18),),
                            const HorizintalSpace(8 ),
                            Text(state.lastPaymentDate,
                            style: const TextStyle(
                            color: kMainColor,
                            fontSize: 18),)] ) ),
                            Padding(
                       padding:  const EdgeInsets.only(top: 1,left: 25),
                       child: Row(
                         children: [
                            const Text("License Expiration date",
                            style: TextStyle(
                            color: kMainColor,
                            fontSize: 18),),
                            const HorizintalSpace(4),
                            Text(userInfo.licenseExpirationDate,
                            style: const TextStyle(
                            color: kMainColor,
                            fontSize: 18),)] ) ),
                            ],);}else{
                              return const Center(child:  CircularProgressIndicator());
                            }
                            }), ]))  ,
                            
                    
    );
      
    
  }
}