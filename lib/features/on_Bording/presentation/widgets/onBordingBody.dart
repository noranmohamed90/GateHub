import 'package:flutter/material.dart';
import 'package:gatehub/cache/cache_helper.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/utiles/service_locator.dart';
import 'package:gatehub/core/utiles/size_config.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/features/Auth/Presentation/login/widgets/loginView.dart';
import 'package:gatehub/features/on_Bording/presentation/widgets/custom_indicator.dart';
import 'package:gatehub/features/on_Bording/presentation/widgets/custome_page_view.dart';
import 'package:get/get.dart';


class OnBordingViewbody extends StatefulWidget {
  const OnBordingViewbody({super.key});
  @override
  State<OnBordingViewbody> createState() => _OnBordingViewbodyState();
}

class _OnBordingViewbodyState extends State<OnBordingViewbody> {
  PageController?pageController;
  @override
  void initState() {
    pageController=PageController(
      initialPage: 0
    )..addListener((){
      setState(() {  
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return    Scaffold(
       backgroundColor: Colors.white,
      body: 
        Stack(
          children: [
           CustomePageView(
            pageController: pageController,
           ),
           Positioned(
            left: 0,
            right: 0,
            bottom: SizeConfig.defualtSize!* 18,
             child:  CustomIndicator(
              dotIndex:  pageController!.hasClients ? pageController?.page :0,
             )
           ),
            Visibility(
              visible:  pageController!.hasClients ? (pageController?. page==2? false:true ):true,
              child: Positioned(
                top: SizeConfig.defualtSize!*10,
                right: 32,
                child: GestureDetector(
                  onTap: (){
                    getIt<CacheHelper>().saveData(
                      key: "isOnBoardingVisited",value: true);
                    Get.off(()=>LoginView());
                  },
                  child: const Text(
                    'Skip', 
                    style: TextStyle
                    (color:kMainColor,
                    fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: SizeConfig.defualtSize!*10,
              left: SizeConfig.defualtSize! *11,
              right: SizeConfig.defualtSize! *11,
              child: CustomeGeneralButton(
                onTap: (){
                  getIt<CacheHelper>().saveData(
                    key: "isOnBoardingVisited",value: true);
                      if(pageController!.page! <2){
                       pageController?.nextPage(
                       duration:const Duration(milliseconds: 300), 
                        curve: Curves.easeIn);
                      }else{
                      Get.off(()=>const LoginView (),
                         transition:Transition.rightToLeft,
                        duration: const Duration(milliseconds: 300));} },
                    text: pageController!.hasClients ? 
                (pageController?. page==2? 'Get Start':"Next" ):'Next',))
          ],
        ),
      
    );
  }
}