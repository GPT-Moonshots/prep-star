import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prepstar/Utils/routes/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp.router(
    routerConfig: AppNavigation.router,
  ));
}


