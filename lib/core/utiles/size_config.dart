import 'package:flutter/material.dart';

class SizeConfig {
  static double? screenHeight;
  static double? screenWidth;
  static double? defualtSize;
  static Orientation? orientation;


  void init(BuildContext context){
    screenHeight =MediaQuery.of(context).size.height;
    screenWidth =MediaQuery.of(context).size.width;
    orientation =MediaQuery.of(context).orientation;


    defualtSize= orientation == Orientation.landscape 
                  ? screenHeight!* .024 
                  : screenWidth!* .024;

        print('this is the defult Size $defualtSize');          
     
  }
}