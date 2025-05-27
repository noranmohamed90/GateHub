import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gatehub/SettingsPage/updatePassword.dart';
import 'package:gatehub/core/constants.dart';
import 'package:gatehub/cubit/bloc/cubit/change_pass_cubit.dart';
import 'package:gatehub/features/Auth/Presentation/login/widgets/loginBody.dart';
import 'package:provider/provider.dart';

class Settingsbody extends StatefulWidget {
  const Settingsbody({super.key});
  @override
  State<Settingsbody> createState() => _SettingsbodyState();
}
class _SettingsbodyState extends State<Settingsbody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePassCubit, ChangePassState>(
      listener: (context, state) {
        if (state is LogOutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        } else if (state is LogOutSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logout successfully!')),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginViewBody()),
          );
        }
      },
      builder: (context, state) {
        if (state is ChangePassLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          color: const Color(0xFFF0F2F5),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  "Settings",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kMainColor),
                ),
              ListTile(
                leading: const Icon(Icons.password),
                title: const Text("Change Password", style: TextStyle(color: kMainColor,fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.pop(context); 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Updatepassword()),
                  );
                },
              ),
              const Divider(height: 0.05, indent: 25, endIndent: 25),
              ListTile(
                title: const Text("Logout", style: TextStyle(color: kMainColor,fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.exit_to_app),
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text("Confirm Logout", style: TextStyle(fontWeight: FontWeight.bold, color: kMainColor)),
                      content: const Text("Are you sure you want to logout?", style: TextStyle(color: kMainColor, fontSize: 15)),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel", style: TextStyle(color: Colors.green))),
                        TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Logout", style: TextStyle(color: Colors.red))),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    context.read<ChangePassCubit>().logOut();
                  }
                },
              ),
               const Divider(height: 0.05, indent: 25, endIndent: 25),
            ],
          ),
        );
      },
    );
  }
}

