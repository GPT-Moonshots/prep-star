import 'package:flutter/material.dart';
import 'package:prepstar/Model/user_model.dart';
import 'package:prepstar/Service/Database/user.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    getUserDetais();
    super.initState();
  }

  void getUserDetais() async {
    UserModel? userModel = await UserDatabase.getUser();
    print(userModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Settings Page'),
      ),
    );
  }
}
