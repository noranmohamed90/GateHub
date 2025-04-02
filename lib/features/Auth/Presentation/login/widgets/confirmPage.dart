import 'package:flutter/material.dart';
import 'package:gatehub/features/Auth/Presentation/login/widgets/confirmPassword.dart';

class Confirmpage extends StatelessWidget {
  const Confirmpage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ConfirmpasswordBody()
    );
  }
}