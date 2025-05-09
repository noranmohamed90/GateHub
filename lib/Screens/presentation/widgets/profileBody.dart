import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/Home/presentation/widgets/notifications.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/Card.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/cubit/login_cubit.dart';
import 'package:gatehub/cubit/notifications_cubit.dart';
import 'package:gatehub/cubit/notifications_states.dart';
import 'package:intl/intl.dart';

class Profilebody extends StatefulWidget {
  Profilebody({super.key});

  @override
  State<Profilebody> createState() => _ProfilebodyState();
}

class _ProfilebodyState extends State<Profilebody> {
   @override
  void initState() {
    super.initState();
    context.read<LoginCubit>().getUserInfo();
  }
  //  final Profileinfo profile=Profileinfo(
  //   userName: 'Ahmed', nationalId: '30397518467853', 
  //   phoneNumber: '01197483261',
  //    vehicle:[VehicleDetails(color: 'black',plateNumber: 'ABC-123',model: 'Mercedes-Benz G-Class'),
  //    VehicleDetails(color: 'white',plateNumber: 'ABC-111',model: 'Toyota Corolla')] );

  //     // transactionModel: [TransactionModel(amount: '100', date: '12/11/2024'),
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if(state is GetUserInfoFailure){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage),));
        }
      },
      builder: (context, state) {
        return   Scaffold(
      backgroundColor: Colors.white,
      appBar:   AppBar(
       // iconTheme: const IconThemeData(color:Colors.white),
        backgroundColor: Colors.white,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: kMainColor,
            fontSize: 22,
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

  })],),
      body: state is GetUserInfoLoading? const CircularProgressIndicator():state is GetUserInfoSuccess?
       SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const  SizedBox(height: 10,),
             Center(
              child: Row(
                children: [
                 const  Padding(
                    padding: EdgeInsets.only(left: 28),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                  ),
                 const HorizintalSpace(2.5),
            Column(
              children: [
                Center(
                  child: Text(
                  state.user.name,
                    style: const TextStyle(fontSize: 22, color: kMainColor,
                    fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
              child: Text(
              state.user.natId,
                style: const TextStyle(fontSize: 15, color: Colors.grey),), ), ],), ], ),), 
              const  VerticalSpace(3),
            //   Padding(
            //     padding: const EdgeInsets.only(left: 25),
            //     child: Column(
            //       children: [
            //         Row(
            //           children: [
            //            const  Icon(Icons.location_on,
            //            color: kMainColor,
            //            size: 20,),
            //            const HorizintalSpace(2),
            //             Text(state.user.address,
            //             style: const TextStyle(fontSize: 15, color: kMainColor)
            //             ),
            //           ],),
            //           const VerticalSpace(2),
            //            Row(
            //             children: [
            //               const  Icon(Icons.phone,
            //               color: kMainColor,
            //               size: 20,
            //               ),
            //                const HorizintalSpace(2),
            //                Text(state.user.phoneNumber,
            //                style: const TextStyle(fontSize: 15, color: kMainColor)), ],),],),),
             CustomeCard(
              //title: 'Government',
              description: state.user.address,
              
              icon: Icons.location_on,
            ),
            CustomeCard(
             // title: 'Phone Number',
              description: state.user.phoneNumber,
              icon: Icons.phone,
            ),
            const VerticalSpace(1),
            const Padding(
            padding: EdgeInsets.only(left: 22),
             child: Text(
               'Vehicles Details ',
        style: TextStyle(
            fontSize: 15,
            color: kMainColor,
            fontWeight: FontWeight.bold),
      ),
    ),
            ListView.builder(
              shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
              itemCount: state.user.vehicles.length,
              itemBuilder: (context, index) {
                 final Vehicle = state.user.vehicles[index];
                return DetailsCard(
                title: Vehicle.type,
               // icon: Icons.directions_car,
                model: Vehicle.modelCompany,
               // plateicon: Icons.confirmation_num,
                num: Vehicle.plateNumber,
               // coloricon: Icons.color_lens,
               licenseEnd: 'License Expiration Date: ${DateFormat('d/MM/yyyy').format(DateTime.parse(Vehicle.licenseEnd))}',
                color: Vehicle.color,

              );} ),
           const Divider(endIndent: 25, indent: 25),
            const Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                'Transaction History',
                style: TextStyle(
                    fontSize: 18,
                    color: kMainColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.user.transactions.length,
                itemBuilder: (context, index) {
                  final transactionHistory = state.user.transactions[index];
                  return Align(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                        color: //Colors.white,
                        const Color(0XFFF9FAFD) ,
                        //const Color(0XFFF7FAFC),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 22,
                            backgroundColor: kMainColor,
                            child: Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                            ),
                          ),
                          const HorizintalSpace(1),
                          Expanded(
                           child:
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactionHistory.paymentType,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: kMainColor
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      transactionHistory.amount.toString(),
                                      style: const TextStyle(fontSize: 15,
                                      color: kMainColor
                                      ),
                                      softWrap: true,
                                      textAlign: TextAlign.start,
                                      
                                    ),
                                   const HorizintalSpace(18),
                                    Text(
                                  transactionHistory.status,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: kMainColor
                                  ),
                                ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                 DateFormat('d/MM/yyyy').format(DateTime.parse(transactionHistory.transactionDate)),
                                  style: const TextStyle( 
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          //),
                       ) ],
                      ),
                    ),
                  );
                },
              ),)])):Container()); });
  }
}
