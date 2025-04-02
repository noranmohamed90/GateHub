import 'package:flutter/material.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/utiles/size_config.dart';

class CustomeGeneralButton extends StatelessWidget {
  const CustomeGeneralButton({super.key, this.text, this.onTap});
final String? text;
final VoidCallback?onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: kMainColor,
          borderRadius:BorderRadius.circular(10) 
        ),
        child:  Center(
          child:  Text(
            text!,
          style:const  TextStyle(
            fontSize: 20,
            color:  Colors.white,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}