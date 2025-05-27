import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/Home/presentation/widgets/notifications.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/utiles/size_config.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/bloc/cubit/fines_cubit.dart';
import 'package:gatehub/cubit/cubit/login_cubit.dart';
import 'package:gatehub/cubit/notifications_cubit.dart';
import 'package:gatehub/cubit/notifications_states.dart';
import 'package:gatehub/models/user_info.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}
String getNearestLicenseDate(UserInfo user) {
  if (user.vehicles.isEmpty) {
    return 'No Vehicles';
  }
  final nearestLicenseEndDate = user.vehicles
      .map((vehicle) => DateTime.parse(vehicle.licenseEnd))
      .toList()
    ..sort();

  return DateFormat('d/MM/yyyy').format(nearestLicenseEndDate.first);
}
Future<void> saveLastPaymentDate() async {
  final prefs = await SharedPreferences.getInstance();
  final now = DateTime.now().toIso8601String(); 
  await prefs.setString('lastPaymentDate', now);
}
Future<DateTime?> getLastPaymentDate() async {
  final prefs = await SharedPreferences.getInstance();
  final dateString = prefs.getString('lastPaymentDate');
  if (dateString == null) return null;
  return DateTime.tryParse(dateString);
}

class _HomeBodyState extends State<HomeBody> {
  DateTime? lastPaymentDate;
  @override
  void initState() {
    super.initState();
    context.read<LoginCubit>().getUserInfo();
     context.read<NotificationCubit>().getNotifications();
     loadLastPaymentDate();
  }
    Future<void> loadLastPaymentDate() async {
    final date = await getLastPaymentDate();
    setState(() {
      lastPaymentDate = date;
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is GetUserInfoFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: [
              BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, notifState) {
                  int unreadCount = 0;
                  if (notifState is NotificationUpdated) {
                    unreadCount = notifState.unreadNotifications;
                  }
                  return Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        color: kMainColor,
                        onPressed: () async{
                          context.read<NotificationCubit>().readNotifications();
                         await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Notifications(),
                            ),
                          ); 
                        },         
                      ),
                      if (unreadCount > 0)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
          body: state is GetUserInfoLoading
              ? const Center(child: CircularProgressIndicator())
              : state is GetUserInfoSuccess
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Center(
                            child: SizedBox(
                              height: SizeConfig.defualtSize! * 12,
                              width: SizeConfig.defualtSize! * 12,
                              child: const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/logo.png'),
                                backgroundColor: kMainColor,
                              ),
                            ),
                          ),
                          const VerticalSpace(2),
                          Text(
                            state.user.name,
                            style: const TextStyle(
                              color: kMainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          const VerticalSpace(1),
                          Text(
                            "Your Balance is ${state.user.balance} EGP",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                          ),
                          const VerticalSpace(8),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              children: [
                                const Text(
                                  "Pending Fees",
                                  style: TextStyle(
                                    color: kMainColor,
                                    fontSize: 18,
                                  ),
                                ),
                                const HorizintalSpace(8),
                                BlocBuilder<FinesCubit, FinesState>(
  builder: (context, finesState) {
    if (finesState is GetFinesInfoSuccess) {
      final totalPending = calculateTotalFines(finesState.fines);
      return Text("$totalPending EGP", style: TextStyle(fontSize: 18, color: Colors.grey));
    } else {
      return const Text("Loading...");
    }
                         })                   ],
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                            indent: 55,
                            endIndent: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 40, left: 15, bottom: 20),
                            child: Row(
                              children: [
                                const Text(
                                  "Last Payment date",
                                  style: TextStyle(
                                    color: kMainColor,
                                    fontSize: 18,
                                  ),
                                ),
                                const HorizintalSpace(9),
                               lastPaymentDate == null
                                    ? const Text(
                                        'NO',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      )
                                    : Text(
                                        DateFormat('d/MM/yyyy')
                                            .format(lastPaymentDate!),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 15),
                            child: Row(
                              children: [
                                const Text(
                                  "License Expiration date",
                                  style: TextStyle(
                                    color: kMainColor,
                                    fontSize: 18,
                                  ),
                                ),
                                const HorizintalSpace(5),
                                Text(
                                  getNearestLicenseDate(state.user),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}
