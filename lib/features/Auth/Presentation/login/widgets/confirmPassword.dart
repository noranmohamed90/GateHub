import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/core/widgets/custome_buttons.dart';
import 'package:gatehub/core/widgets/custome_textfeild.dart';
import 'package:gatehub/core/widgets/sapce_widget.dart';
import 'package:gatehub/features/Auth/Presentation/login/widgets/loginView.dart';

class ConfirmpasswordBody extends StatefulWidget {
  const ConfirmpasswordBody({super.key});

  @override
  State<ConfirmpasswordBody> createState() => _ConfirmpasswordBodyState();
}

class _ConfirmpasswordBodyState extends State<ConfirmpasswordBody> {
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  String passwordStrength = "Weak";
  Color strengthColor = Colors.red;

  void _updatePasswordStrength(String password) {
    String strength = checkStrength(password);

    setState(() {
      passwordStrength = strength;
      strengthColor = (strength == "Weak")
          ? Colors.red
          : (strength == "Medium")
              ? Colors.orange
              : Colors.green;
    }); }

  String checkStrength(String password) {
    if (password.isEmpty || password.length < 6) {
      return 'Weak';
    }
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'\d'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

   if (password.length >= 10 && hasDigits && hasSpecialCharacters && hasUppercase) {
    return 'Strong'; 
  } if (password.length >= 6 && hasDigits && hasUppercase) {
    return 'Medium';
  }return 'Weak';
  }

  void confirm() {
    if (passController.text.isEmpty || confirmPassController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required!')), );
      return;
    } if (passController.text != confirmPassController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The passwords do not match!'),
          backgroundColor: Colors.red,
        ), );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset successfully!'),
          backgroundColor: Colors.green,
        ),);
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );});}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Create New Password',
                style: TextStyle(
                  color: kMainColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const VerticalSpace(5),
              const Text(
                "You're almost there! Set a strong password with at least 8 characters, including uppercase letters, numbers, and special symbols, to secure your account.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const VerticalSpace(3),
              SizedBox(
                height: 50,
                child: CustomeTextfeild(
                  onChanged:(value)=>_updatePasswordStrength(value),
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(12),
                  ],
                  isPassword: true,
                  controller: passController,
                  hinttext: 'New Password',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Password Strength: $passwordStrength",
                style: TextStyle(
                  color: strengthColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const VerticalSpace(3),
              SizedBox(
                height: 50,
                child: CustomeTextfeild(
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(12),
                  ],
                  isPassword: true,
                  controller: confirmPassController,
                  hinttext: 'Confirm Password',
                ),
              ),
              const VerticalSpace(10),
              SizedBox(
                height: 55,
                width: 180,
                child: CustomeGeneralButton(
                  text: 'Reset Password',
                  onTap: confirm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
