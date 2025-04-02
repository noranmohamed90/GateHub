import 'package:flutter/material.dart';
import 'package:gatehub/Settings/widgets/setting_Screen.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingView> {
   // ignore: unused_field
   Locale _locale = const Locale('en');

  void _changeLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SettingsScreen(onLanguageChanged: _changeLanguage)
    );
  }
}