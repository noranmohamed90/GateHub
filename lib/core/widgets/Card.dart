import 'package:flutter/material.dart';
import 'package:gatehub/core/constants.dart';

class CustomeCard extends StatelessWidget {
  const CustomeCard({super.key, required this.description, this.icon});
  //final String?title;
  final String ? description;
  final IconData ?icon;

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:EdgeInsets.symmetric(horizontal: 12.0),
          // child: Text(title!,
          // style: const TextStyle(
          //   color: kMainColor,
          //   fontSize: 15,
          //   fontWeight: FontWeight.bold
          // ),),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8,left: 8),
          child: Card( 
            child: ListTile(
              tileColor: Colors.white,
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              leading: Icon(icon!,
              color: kMainColor,),
              title: Text(description!,
              // style: TextStyle(
              //   color: Colors.white
              // ),
              )
              ,
            ),),
        )
      ],
    );
  }
}




class DetailsCard extends StatelessWidget {
  const DetailsCard({super.key, this.title, this.model, this.num, this.color, this.caricon, this.plateicon, this.coloricon, this.icon, this.type, this.licenseEnd});
  final String?title;
  final String ? model;
  final String ? num;
  final String ? color;
  final IconData? icon;
  final IconData ?caricon;
  final IconData ?plateicon;
  final IconData ?coloricon;
  final String?type;
  final String?licenseEnd;

  @override
  Widget build(BuildContext context) {
    return   ExpansionTile(
      title: Text( title!,
      style: const  TextStyle(
        color: kMainColor,
        fontSize: 15,
        fontWeight: FontWeight.bold),),
      trailing: const Icon(Icons.keyboard_arrow_down,
      color: kMainColor,),
      children: <Widget>[
        ListTile(
          tileColor: Colors.white,
         // leading: Icon(icon),
          title: Text(model!,
          style:const  TextStyle(
        color: kMainColor,
        fontSize: 13,),),),
        ListTile(
           tileColor: Colors.white,
        //  leading: Icon(plateicon),
          title: Text(num!,
          style:const  TextStyle(
         color: kMainColor,
        fontSize: 13,),),),
        ListTile(
          tileColor: Colors.white,
         // leading: Icon(coloricon),
          title: Text(color!,
          style:const  TextStyle(
        color: kMainColor,
        fontSize: 13,),),),
        ListTile(
          tileColor: Colors.white,
         // leading: Icon(icon),
          title: Text(licenseEnd!,
          style:const  TextStyle(
        color: kMainColor,
        fontSize: 13,),),),
        
        
      ],

      );
  }
}