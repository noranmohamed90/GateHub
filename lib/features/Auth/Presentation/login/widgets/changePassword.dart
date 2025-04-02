import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/core/widgets/custome_textfeild.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/features/Auth/Presentation/login/widgets/otp_code.dart';


class ChangepasswordBody extends StatefulWidget {
  const ChangepasswordBody({super.key});

  @override
  State<ChangepasswordBody> createState() => _ChangepasswordBodyState();
}
class _ChangepasswordBodyState extends State<ChangepasswordBody> {
     final TextEditingController phoneController = TextEditingController();

void changePass() {
  if (!mounted) return; 
  if (phoneController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enter your phone')),);
    return;
  }  else if (!RegExp(r'^(010|011|012|015)[0-9]{8}$').hasMatch(phoneController.text)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(' Invalid phone number')) );
    return;
  } else {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const OtpCode()),
    );}
}  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                child: Icon(Icons.lock,
                size:130 ,
                color: kMainColor,)   ),),
             const VerticalSpace(4),
            const  Padding(
               padding: EdgeInsets.only(left: 25),
               child: Text('Forget Password',
                  style: TextStyle(fontSize: 25,
                   color: kMainColor,),),),
         const  VerticalSpace(4),
         const  Padding(
        padding: EdgeInsets.only(left: 25,right: 25,bottom: 12),
        child: Text('Provide Your Phone Number and we will send you a code to reset your password',
        style: TextStyle(
          color: Colors.grey,
        ),) ),
      SizedBox(
                height: 55,
                child: CustomeTextfeild(
                  controller: phoneController,
                  type:TextInputType.number ,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11)
                  ],
                  hinttext: ' Enter your phone number',
                   ),),
                  const VerticalSpace(10),
                Center(
                 child:  SizedBox(
                  height: 55,
                  width: 180,
                  child: CustomeGeneralButton(
                    text: 'Next', 
                    onTap: changePass,             
                  ), ), ),
       ])) );
  }
}