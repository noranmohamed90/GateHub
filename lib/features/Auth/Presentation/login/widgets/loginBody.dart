import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/utiles/size_config.dart';
import 'package:gatehub/core/widgets/custome_bottomNavigatingBar.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/core/widgets/custome_textfeild.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/cubit/cubit/login_cubit.dart';
import 'package:gatehub/features/Auth/Presentation/login/widgets/changePass_Page.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  // final TextEditingController natIdController = TextEditingController();
  // final TextEditingController passwordController = TextEditingController();

  // String? validateInput() {
  //   if (natIdController.text.isEmpty || passwordController.text.isEmpty) {
  //     return 'Both fields are required.';
  //   } else if (natIdController.text.length != 14) {
  //     return 'National ID must be exactly 14 digits.';
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text('Login Success')),
                
              // );
              context.read<LoginCubit>().getUserInfo();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomeBottomnavigatingbar(),
                ),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Invalid ID or Passwors'),backgroundColor: Colors.red,),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                const VerticalSpace(8),
                Image.asset(
                  'assets/images/logo.png',
                  height: SizeConfig.defualtSize! * 35,
                  width: SizeConfig.defualtSize! * 45,
                ),
                const Text(
                  'Log in to your Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: kMainColor,
                  ),
                ),
                const VerticalSpace(1),
                SizedBox(
                  height: 55,
                  child: CustomeTextfeild(
                    controller:context.read<LoginCubit>().natIdController,
                    type: TextInputType.number,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(14),
                    ],
                    hinttext: 'Your National ID',
                  ),
                ),
                const VerticalSpace(3),
                SizedBox(
                  height: 55,
                  child: CustomeTextfeild(
                    controller:context.read<LoginCubit>().passwordController,
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangepassPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: kMainColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const VerticalSpace(8),
                //state is LoginLoading ? 
                //const CircularProgressIndicator():
                SizedBox(
                  height: 55,
                  width: 180,
                  child: CustomeGeneralButton(
                    text: state is LoginLoading ? 'Loading...' : 'Log In',
                    onTap: () async{
                       String? validationMessage =context.read<LoginCubit>().validateInput();
                      if (validationMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(validationMessage)),
                        );
                        return;
                      }
                      await context.read<LoginCubit>().getDeviceToken();
                      context.read<LoginCubit>().loginUser();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
