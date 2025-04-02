import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/Payment/Provider/fee_Provider.dart';
import 'package:gatehub/cubit/balance_cubit.dart';
import 'package:gatehub/cubit/notifications_cubit.dart';
import 'package:gatehub/features/splash/presentation/splashview.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FeeProvider(),),
        BlocProvider(create: (context)=>BalanceCubit()),
        BlocProvider(create: (context)=>NotificationCubit())
      ],
      child: const GateHub()));
}

class GateHub extends StatelessWidget {
  const GateHub({super.key});

  @override
  Widget build(BuildContext context) {
    return  const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splashview(),
    );
  }
}

