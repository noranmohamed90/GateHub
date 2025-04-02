import 'package:flutter/material.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/utiles/size_config.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, this.title, this.subTitle, this.image});
   final String?title;
   final String?subTitle;
   final String?image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      const VerticalSpace(12),
        Container(
          height: SizeConfig.defualtSize!*40,
          width: SizeConfig.defualtSize!*55,
          child: Image.asset(image!)),
         const  VerticalSpace(3),
        Text(title!,
        style: const TextStyle
            (color:kMainColor,
            fontWeight: FontWeight.bold,
            fontSize: 20),
            textAlign: TextAlign.left,),
            const  VerticalSpace(1),
        Text(subTitle!,
        style: const TextStyle
            (color:kMainColor,
            fontSize: 16),
            textAlign: TextAlign.left,
        ),

      ],
    );
  }
}