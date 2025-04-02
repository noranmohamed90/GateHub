import 'package:flutter/material.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/features/splash/presentation/widgets/splashbody.dart';

class Splashview extends StatelessWidget {
  const Splashview({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: kMainColor,
      body:SplashBody() ,
    );
  }
}


