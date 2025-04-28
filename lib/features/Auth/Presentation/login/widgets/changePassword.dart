import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/core/widgets/custome_textfeild.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/bloc/email_cubit/email_cubit_cubit.dart';
import 'package:gatehub/features/Auth/Presentation/login/widgets/otp_body.dart';


class ChangepasswordBody extends StatefulWidget {
  const ChangepasswordBody({super.key});

  @override
  State<ChangepasswordBody> createState() => _ChangepasswordBodyState();
}
class _ChangepasswordBodyState extends State<ChangepasswordBody> { 

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<EmailCubitCubit, EmailCubitState>(
      listener: (context, state) {
       if(state is EmailFailure){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
       }else if(state is EmailSuccess){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check Your Email !')));
        Future.delayed(const Duration(seconds: 2),(){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const OtpBody(),
      ));

        });  }  },
      builder: (context, state) {
        return 
    Scaffold(
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
        child: Text('Enter your email to receive an OTP for password reset.',
        style: TextStyle(
          color: Colors.grey,
        ),) ),
      SizedBox(
                height: 55,
                child: CustomeTextfeild(
                  controller: context.read<EmailCubitCubit>().emailController,
                  type:TextInputType.emailAddress ,
                  // inputFormatter: [
                  //   FilteringTextInputFormatter.digitsOnly,
                  //   LengthLimitingTextInputFormatter(11)
                  // ],
                  hinttext: ' Enter your email',
                   ),),
                  const VerticalSpace(10),
                Center(
                 child:  SizedBox(
                  height: 55,
                  width: 180,
                  child: CustomeGeneralButton(
                    text: 'Send Code', 
                    onTap: (){
                      context.read<EmailCubitCubit>().emailValidation();
                    }             
                  ), ), ),
       ])) );

});}}