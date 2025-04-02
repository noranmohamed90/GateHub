import 'package:flutter/material.dart';
import 'package:gatehub/core/utiles/size_config.dart';
import 'package:gatehub/features/on_Bording/presentation/on_bordingview.dart';
import 'package:get/get.dart';
class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with SingleTickerProviderStateMixin{
  // AnimationController ?animationController;
  // Animation <double>?fadingAnimation;

  // @override
   void initState() {
     super.initState();
     goToNextView();
  //   animationController =AnimationController(vsync:this,duration: Duration(microseconds: 600) );
  //   fadingAnimation = Tween<double>(begin: .2 ,end: 1).animate(animationController!);
  //   animationController?.repeat(reverse: true);
   }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: TweenAnimationBuilder(
          duration: const Duration(seconds: 2),
          tween: Tween<double>(begin: 0.0, end: 1.0),
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },child: Center(child: Image.asset('assets/images/logo.png')) ,
          ) );
  }
  
  void goToNextView() {
    Future.delayed(Duration(seconds: 3),(){
      Get.to(()=>OnBordingview(), transition: Transition.zoom);
    }
    );
  }
}


