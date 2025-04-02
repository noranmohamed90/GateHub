import 'package:flutter/material.dart';
import 'package:gatehub/Home/presentation/widgets/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: HomeBody(),
    );
    
  }
}