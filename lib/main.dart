import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prepstar/View/Auth/login_page.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? uid = await storage.read(key: 'uid');
  runApp(MaterialApp(
    title: 'Prep Star',
    home: (uid == null)
        ? const LoginScreen()
        : Placeholder(),
    debugShowCheckedModeBanner: false,
  ));
}
