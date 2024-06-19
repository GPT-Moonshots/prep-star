import 'package:flutter/material.dart';
import 'package:prepstar/Service/Auth/o_auth.dart';
import 'package:prepstar/Service/Database/course.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practice'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  OauthService.logout(context);
                },
                child: Text('Logout')),
            ElevatedButton(
              onPressed: () async {
                await CourseDatabase.uploadCourse().then((value) {
                  print('Course uploaded successfully!');
                });
              },
              child: Text('Upload Course'),
            )
          ],
        ),
      ),
    );
  }
}
