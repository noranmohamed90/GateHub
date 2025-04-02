import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/Home/presentation/widgets/notifications.dart';
import 'package:gatehub/Screens/Model/profileInfo.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/Card.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/balance_cubit.dart';
import 'package:gatehub/cubit/balance_states.dart';
import 'package:gatehub/cubit/notifications_cubit.dart';
import 'package:gatehub/cubit/notifications_states.dart';

class Profilebody extends StatelessWidget {
  Profilebody({super.key});
   
   final Profileinfo profile=Profileinfo(
    userName: 'Ahmed', nationalId: '30397518467853', 
    phoneNumber: '01197483261',
     vehicle:[VehicleDetails(color: 'black',plateNumber: 'ABC-123',model: 'Mercedes-Benz G-Class'),
     VehicleDetails(color: 'white',plateNumber: 'ABC-111',model: 'Toyota Corolla')] );
      // transactionModel: [TransactionModel(amount: '100', date: '12/11/2024'),
      // TransactionModel(amount: '150', date: '5/9/2024'),
      // TransactionModel(amount: '100', date: '22/5/2024'),
      //]);
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       // iconTheme: const IconThemeData(color:Colors.white),
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: kMainColor,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        leading: Navigator.of(context).canPop() ?
        IconButton(icon:const Icon(Icons.arrow_back),
        onPressed: ()=>Navigator.of(context).maybePop()):null,
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

  })],
        
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 25),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
            ),
            const VerticalSpace(1.5),
            Center(
              child: Text(
                profile.userName,
                style: const TextStyle(fontSize: 23, color: kMainColor),
              ),
            ),
           const  VerticalSpace(2),
            CustomeCard(
              title: 'National ID',
              description: profile.nationalId,
              icon: Icons.badge,
            ),
            CustomeCard(
              title: 'Phone Number',
              description: profile.phoneNumber,
              icon: Icons.phone,
            ),
            const Padding(
            padding: EdgeInsets.all(8.0),
             child: Text(
               'Vehicles',
        style: TextStyle(
            fontSize: 18,
            color: kMainColor,
            fontWeight: FontWeight.bold),
      ),
    ),
            ListView.builder(
              shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
              itemCount: profile.vehicle.length,
              itemBuilder: (context, index) {
                 final Vehicle = profile.vehicle[index];
                 return  DetailsCard(
                title: 'Vechile ${index+1}',
                icon: Icons.directions_car,
                model: 'Model :${Vehicle.model}',
                plateicon: Icons.confirmation_num,
                num: 'Plate No :${Vehicle.plateNumber}',
                coloricon: Icons.color_lens,
                color: 'Color :${Vehicle.color}',
              );
              }
            ),
           const Divider(endIndent: 25, indent: 25),

            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Transaction History',
                style: TextStyle(
                    fontSize: 18,
                    color: kMainColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            BlocBuilder<BalanceCubit,BalanceState>
            (builder: (context,state) {
             if(state is UpdateBalanceState){
              return  ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                final transaction = state.transactions[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.battery_charging_full,
                          size: 30, color: kMainColor),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recharge',
                            style: TextStyle(
                                fontSize: 18,
                                color: kMainColor,
                                 // fontWeight: FontWeight.bold
                                 ),
                          ),
                          Text(
                            transaction['amount']!,
                            style: const TextStyle(
                                fontSize: 18, color: kMainColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        transaction['date']!,
                        style:
                            const TextStyle(fontSize: 16, color: kMainColor),
                      ),
                    ],
                  ),
                );
              },
            );
             }else{
              return const CircularProgressIndicator();
             }
            })
            
           
          ],
        ),
      ),
     
    );
  }
}
