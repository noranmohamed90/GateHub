import 'package:flutter/material.dart';
import 'package:gatehub/core/utiles/size_config.dart';

class HorizintalSpace extends StatelessWidget {
  const HorizintalSpace(this.value);
   final double? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.defualtSize !*value!,
    );
  }
}


class  VerticalSpace extends StatelessWidget {
  const VerticalSpace(this.value);
  final double? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.defualtSize! * value!,
    );
  }
}