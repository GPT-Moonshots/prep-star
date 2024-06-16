import 'package:flutter/material.dart';
import 'package:prepstar/Service/Auth/o_auth.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
      ),
      body:  Center(
        child: ElevatedButton(onPressed: () async {
          OauthService.logout(context);
        }, child: Text('Logout')),
      ),
    );
  }
}
