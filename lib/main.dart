import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prepstar/Utils/routes/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp.router(
    routerConfig: AppNavigation.router,
  ));
}
