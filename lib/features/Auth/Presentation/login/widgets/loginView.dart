import 'package:flutter/material.dart';
import 'package:gatehub/features/Auth/Presentation/login/widgets/loginBody.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginViewBody(),
    );
    
  }
}