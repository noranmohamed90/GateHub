import 'package:flutter/material.dart';
import 'package:gatehub/Settings/localization/app_localization.dart';
import 'package:gatehub/Settings/widgets/custome_text_feild.dart';

class SettingsScreen extends StatefulWidget {
  final Function(String) onLanguageChanged;

  const SettingsScreen({super.key, required this.onLanguageChanged});

  @override
  State<SettingsScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          AppLocalizations.translate(context, 'Settings'),
          style: const TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: Color(0xff1a354a),
          ),
        ),
        leading: Navigator.of(context).canPop() ?
        IconButton(icon:Icon(Icons.arrow_back,size: 35,),
        onPressed: ()=>Navigator.of(context).maybePop()):null,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: nameController,
                label: AppLocalizations.translate(context, 'name'),
                labelStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold, //
                  color: Color(0xff1a354a),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: passwordController,
                label: AppLocalizations.translate(context, 'password'),
                labelStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold, //
                  color: Color(0xff1a354a),
                ),
              ),
              const SizedBox(height: 20),
              _buildSettingsOption(
                  AppLocalizations.translate(context, 'manage_notifications')),
              _buildSettingsOption(
                  AppLocalizations.translate(context, 'deactivate_account')),
              const SizedBox(height: 20),
              Text(AppLocalizations.translate(context, 'support'),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1a354a))),
              _buildSettingsOption(
                  AppLocalizations.translate(context, 'logout')),
              _buildLanguageSelector(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("Name: ${nameController.text}");
                  print("Password: ${passwordController.text}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Center(
                  child: Text(
                      AppLocalizations.translate(context, 'Save changes'),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsOption(String title, {String? trailing}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xff1a354a),
        ),
      ),
      trailing: trailing != null
          ? Text(
              trailing,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          : const Icon(Icons.arrow_forward, color: Color(0xff1a354a)),
      onTap: () {},
    );
  }

  Widget _buildLanguageSelector() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(AppLocalizations.translate(context, 'language'),
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xff1a354a))),
      trailing: DropdownButton<String>(
        value: AppLocalizations.getCurrentLocale(context),
        items: const [
          DropdownMenuItem(value: "en", child: Text("English")),
          DropdownMenuItem(value: "ar", child: Text('Arabic')),
        ],
        onChanged: (value) {
          if (value != null) {
            widget.onLanguageChanged(value);
          }
        },
      ),
    );
  }
}