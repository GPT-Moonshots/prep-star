import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prepstar/Service/Auth/o_auth.dart';

class AuthServices {
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  static Future<String?>? signUpWithEmailPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User user = userCredential.user!;
      storage.write(key: 'uid', value: user.uid);
      // print('Signed up as: ${user.displayName}');
      return null;
    } catch (e) {
      // print('Sign-up failed: $e');
      // Handle sign-up failure here
      return 'Sign-up failed';
    }
  }

  // Signin using email and password

  static Future<String?>? signInWithEmailPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = userCredential.user!;
      storage.write(key: 'uid', value: user.uid);
      // print('Signed in as: ${user.displayName}');
      return null;
    } catch (e) {
      // print('Sign-in failed: $e');
      // Handle sign-in failure here
      return 'Sign-in failed';
    }
  }

  // Signout

  static Future<void> signOut() async {
    storage.deleteAll();
    await FirebaseAuth.instance.signOut();
  }

  // Reset password

  static Future<String?>? resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } catch (e) {
      // print('Reset password failed: $e');
      return 'Reset password failed';
    }
  }

  static Future<String?>? deleteAccount(BuildContext context) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      await storage.deleteAll();
      try {
        if (user.photoURL == null) {
          TextEditingController passwordController = TextEditingController();
          // take password from user
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text('Enter your password'),
                  content: TextField(
                    obscureText: true,
                    controller: passwordController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          await user.reauthenticateWithCredential(
                              EmailAuthProvider.credential(
                                  email: user.email!,
                                  password: passwordController.text));
                          await user.delete();
                          Navigator.pop(context);
                        },
                        child: const Text('Delete')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                  ],
                );
              });
        } else {
          if (user.providerData[0].providerId == 'google.com') {
            OauthService.signInWithGoogle().then((_) async {
              log('reauthenticated with google');
              await user.delete();
            });
          } else if (user.providerData[0].providerId == 'apple.com') {
            OauthService.signInWithApple()?.then((_) async {
              log('reauthenticated with apple');
              await user.delete();
            });
          }
        }
        Navigator.pop(context);
      } catch (e) {
        // print('Error deleting user: $e');
      }
      return null;
    } catch (e) {
      // print('Delete account failed: $e');
      return 'Delete account failed';
    }
  }
}
