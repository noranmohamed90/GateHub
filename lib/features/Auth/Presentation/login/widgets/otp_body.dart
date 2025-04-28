import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/core/widgets/custome_textfeild.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/bloc/otpCubit/cubit/otp_cubit.dart';
import 'package:gatehub/features/Auth/Presentation/login/widgets/loginBody.dart';

class OtpBody extends StatefulWidget {
  const OtpBody({super.key});

  @override
  State<OtpBody> createState() => _OtpBodyState();
}
class _OtpBodyState extends State<OtpBody> {
  bool isOtpEntered = false;

  @override  
  Widget build(BuildContext context) {
    return  BlocConsumer<OtpCubit, OtpState>(
    listener: (context, state) {
       if (state is OtpFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              } else if (state is OtpSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Your password has been changed successfully! ')) );
           Future.delayed(const Duration(seconds: 2),(){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginViewBody(),
      ));

        });  }  },
     builder: (context, state) {
              if (state is OtpLoading) {
                return const Center(child: CircularProgressIndicator());
              }  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Reset Password',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: kMainColor),
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top:18),
                child: 
                Icon(Icons.verified,
                size:130 ,
                color: kMainColor,),
                ), ),
                const VerticalSpace(2),  
           const  Padding(
              padding:  EdgeInsets.only(left:25,right: 25),
              child:  Text('Enter the OTP code you just received, create a new password, and confirm it',
                  style: TextStyle(
                    color: kMainColor,
                    fontSize: 16)),
            ),
             const VerticalSpace(3),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: TextField(
                      onChanged: (value){
                      if (value.isNotEmpty) {
                       setState(() {
                        isOtpEntered = true;
                          });}else{
                         setState(() {
                         isOtpEntered = false; });}
                      },
                      controller: context.read<OtpCubit>().otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      textAlign: TextAlign.center,
                      cursorColor: kMainColor,
                      decoration: const InputDecoration(
                         hintText: '_ _ _ _ _ _',
                          hintStyle:TextStyle(color: Colors.grey),
                          counterText: "", 
                          border: OutlineInputBorder(),
                           contentPadding: EdgeInsets.symmetric(vertical: 8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey,width: 2),
                          ),focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: kMainColor,width: 2),) ),  ), ),
                            const VerticalSpace(2),                    
           const  Padding(
              padding:  EdgeInsets.only(left:25,right: 25),
              child:  Text('Your password must have at least (10 characters, Includes uppercase(A-Z), lowercase(a-z), number(0-9), and special character(!@#\$%^&*) .',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12)),
            ),
                            SizedBox(
                  height: 50,
                  width: 300,
                  child: CustomeTextfeild(
                    enabled: isOtpEntered,
                    inputFormatter: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    isPassword: true,
                    controller: context.read<OtpCubit>().passController,
                    hinttext: 'New Password',
                  ),
                ),
                const SizedBox(height: 10),
                const VerticalSpace(2),
                SizedBox(
                  height: 50,
                  width: 300,
                  child: CustomeTextfeild(
                    enabled: isOtpEntered,
                    inputFormatter: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    isPassword: true,
                    controller: context.read<OtpCubit>().confirmPassController,
                    hinttext: 'Confirm Password',
                  ),
                ),
                const VerticalSpace(6),
                SizedBox(
                  height: 55,
                  width: 180,
                  child: CustomeGeneralButton(
                    text: 'Reset Password',
                    onTap: (){
                             context.read<OtpCubit>().verfiyOtp();
                    } 
                  ),
                ),
                ]),
            ),
])));

  });}
  }
