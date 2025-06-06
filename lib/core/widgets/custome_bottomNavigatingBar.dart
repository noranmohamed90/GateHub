import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/Home/presentation/Home.dart';
import 'package:gatehub/Screens/presentation/profile.dart';
import 'package:gatehub/SettingsPage/settingView.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/cubit/bloc/cubit/change_pass_cubit.dart';
import 'package:gatehub/paymentScreen/paymentView.dart';
import 'package:gatehub/recharge/rechargeView.dart';

class CustomeBottomnavigatingbar extends StatefulWidget {
  const CustomeBottomnavigatingbar({super.key});
  @override
  State<CustomeBottomnavigatingbar> createState() => _CustomeBottomnavigatingbarState();
}
class _CustomeBottomnavigatingbarState extends State<CustomeBottomnavigatingbar> {
  int selectedIndex = 0;
  final List<Widget> pages = [
  const HomeScreen(),     
  const PaymentView(),     
  const RechargeView(), 
  const ProfileView(),     
   Container(),    
];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: () async {
      if (selectedIndex != 0) {
        setState(() {
          selectedIndex =  selectedIndex-1; 
        });
        return false;
      }
      return true; 
    },
    child:  Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages, 
      ),
      bottomNavigationBar:  BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          onTap: (value) {
            if (value == 4) {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                ),
                isScrollControlled: true,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocProvider.value(
                    value: BlocProvider.of<ChangePassCubit>(context),
                    child: const Settingview(),
                  ),
                ),
              );
              return;
            }

            setState(() {
              selectedIndex = value;
            });
          },
          currentIndex: selectedIndex,
          backgroundColor:  Colors.white, 
          //Color(0xFFEEEEE9),
          selectedItemColor: kMainColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          iconSize: 24,
          selectedFontSize: 12,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedFontSize: 10,
          items: const [
  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet ), label: 'Payment'),
  BottomNavigationBarItem(icon: Icon(Icons.autorenew), label: 'Recharge'),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
],
        ),
      ),
    );
  }
}
