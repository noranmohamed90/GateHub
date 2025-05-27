import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/core/widgets/custome_textFeild.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/bloc/cubit/change_pass_cubit.dart';

class Updatepasswordbody extends StatefulWidget {
  const Updatepasswordbody({super.key});

  @override
  State<Updatepasswordbody> createState() => _UpdatepasswordbodyState();
}

class _UpdatepasswordbodyState extends State<Updatepasswordbody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePassCubit,ChangePassState>(
       listener: (context,state){
        if(state is ChangePassFailure){
           ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
        }else if(state is ChangePassSuccess){
           ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Your password has been changed successfully! ')) ); }
       },
    builder: (context, state) {
              if (state is ChangePassLoading) {
                return const Center(child: CircularProgressIndicator());
              }  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Change Password',
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
                Icon(Icons.lock,
                size:130 ,
                color: kMainColor,),
                ), ),
                const VerticalSpace(2),  
           const  Padding(
              padding:  EdgeInsets.only(left:25,right: 25),
              child:  Text('Update your password by entering your current password, followed by your new one.',
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
                  height: 60,
                  width: 300,
                  child: CustomeTextfeild(
                    inputFormatter: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    isPassword: true,
                    controller: context.read<ChangePassCubit>().currentpassController,
                    hinttext: 'Your Current Password',
                  ),
                ),  const SizedBox(height: 20),                
                   SizedBox(
                  height: 60,
                  width: 300,
                  child: CustomeTextfeild(
                    inputFormatter: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    isPassword: true,
                    controller:context.read<ChangePassCubit>().newPassController,
                    hinttext: 'New Password',
                  ),
                ),
                const SizedBox(height: 10),
                const VerticalSpace(2),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: CustomeTextfeild(
                    inputFormatter: [
                      LengthLimitingTextInputFormatter(12),
                    ],
                    isPassword: true,
                   controller: context.read<ChangePassCubit>().confirmPassController,
                    hinttext: 'Confirm Password',
                  ),
                ),
                const VerticalSpace(10),
                SizedBox(
                  height: 55,
                  width: 180,
                  child: CustomeGeneralButton(
                    text: 'Save Changes',
                    onTap: (){
                  context.read<ChangePassCubit>().changePass();
                    } 
                  ),
                ),
                ]),
            ),
])));

  });}
}