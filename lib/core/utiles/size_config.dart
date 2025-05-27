import 'package:flutter/material.dart';
import 'package:gatehub/models/finesModel.dart';

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

double calculateTotalFines(List<Finesmodel> fines) =>
  fines.fold(0, (sum, fine) => sum + ((fine.feeValue ?? 0) + (fine.fineValue ?? 0)));
