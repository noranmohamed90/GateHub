import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/utiles/size_config.dart';
import 'package:gatehub/core/widgets/custome_bottomNavigatingBar.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/core/widgets/custome_textfeild.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/features/Auth/Presentation/login/widgets/changePass_Page.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});
  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}
class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  void login() {
    if (idController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('This Feilds are required'))
      );
    }else if (idController.text.length!=14){
       ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('You must enter exactly 14 digit for National ID')));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const CustomeBottomnavigatingbar()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.white,
      body : SingleChildScrollView(
          child: Column(
            children: [
             const  VerticalSpace(8),
              Image.asset('assets/images/logo.png',
              height: SizeConfig.defualtSize!*35, 
              width:  SizeConfig.defualtSize!*45,
              ),
             const  Text('Log in to your Account',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: kMainColor
              ),),
             const VerticalSpace(1),
              SizedBox(
                height: 55,
                child: CustomeTextfeild(
                  controller: idController,
                  type:TextInputType.number ,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(14)
                  ],
                  hinttext: ' Your National ID', 
                ),
              ),
              const VerticalSpace(3),
              SizedBox(
                height: 55,
                child: CustomeTextfeild(
                  controller: passwordController,
                 isPassword: true,
                  type: TextInputType.text,
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(12),
                  ],
                  hinttext: 'Your Password',
                ),
                ),
               const VerticalSpace(1),
                Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: GestureDetector(
                    onTap:(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChangepassPage()));
                    },
                    child: const Text('Forget Password?',
                    style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: kMainColor),
                    ),
                  ),
                )),
             const VerticalSpace(8),
              SizedBox(
                height: 55,
                width: 180,
                child: CustomeGeneralButton(
                  text: 'Log In',
                  onTap: login                 
                ),
              ),
            ],
          ),
        ),
    );
      
    
  }
} 