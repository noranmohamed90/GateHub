import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/Payment/Provider/fee_Provider.dart';
import 'package:gatehub/cache/cache_helper.dart';
import 'package:gatehub/core/utiles/service_locator.dart';
import 'package:gatehub/cubit/balance_cubit.dart';
import 'package:gatehub/cubit/bloc/cubit/change_pass_cubit.dart';
import 'package:gatehub/cubit/bloc/cubit/fines_cubit.dart';
import 'package:gatehub/cubit/bloc/cubit/payment_cubit.dart';
import 'package:gatehub/cubit/bloc/email_cubit/email_cubit_cubit.dart';
import 'package:gatehub/cubit/bloc/otpCubit/cubit/otp_cubit.dart';
import 'package:gatehub/cubit/cubit/login_cubit.dart';
import 'package:gatehub/cubit/cubit/objection_cubit.dart';
import 'package:gatehub/cubit/cubit/recharge_cubit.dart';
import 'package:gatehub/cubit/notifications_cubit.dart';
import 'package:gatehub/features/splash/presentation/splashview.dart';
import 'package:gatehub/firebase_options.dart';
import 'package:gatehub/services/dio_consumer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  await getIt<CacheHelper>().init();
 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FeeProvider(),),
        BlocProvider(create: (context)=>BalanceCubit()),
        BlocProvider(create: (context)=>EmailCubitCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (context)=>OtpCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (context)=>NotificationCubit(DioConsumer(dio: Dio()))..initNotifications()),
        BlocProvider(create: (context) => LoginCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (context)=>ChangePassCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (context)=>RechargeCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (context)=>PaymentCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (context)=>ObjectionCubit(DioConsumer(dio: Dio()))),
        BlocProvider(create: (context)=>FinesCubit(DioConsumer(dio: Dio()))..getFinesInfo()),

      ],
      child: const GateHub()));
}

class GateHub extends StatelessWidget {
  const GateHub({super.key});

  @override
  Widget build(BuildContext context) {
    
        return const  GetMaterialApp(
      // localizationsDelegates: const[
      //           S.delegate,
      //           GlobalMaterialLocalizations.delegate,
      //           GlobalWidgetsLocalizations.delegate,
      //           GlobalCupertinoLocalizations.delegate,
      //       ],
      //       supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
    
      home: Splashview(),
    );
  }


}