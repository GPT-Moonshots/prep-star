import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:prepstar/Service/Database/user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class OauthService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> signInWithGoogle() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        final User user = userCredential.user!;
        _storage.write(key: 'uid', value: user.uid);
        if (userCredential.additionalUserInfo!.isNewUser) {
          await UserDatabase.createUser(user);
        }
        return null;
      } else {
        log('Sign-in with Google failed');
        return 'Sign-in with Google failed';
      }
    } catch (e) {
      log('Sign-in with Google failed due to $e');
      return 'Sign-in with Google failed';
    }
  }

  static Future<String?>? signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'your_client_id',
          redirectUri: Uri.parse(
            'https://your-redirect-uri.com',
          ),
        ),
      );

      final OAuthProvider oAuthProvider = OAuthProvider("apple.com");
      final AuthCredential authCredential = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(authCredential);

      final User user = userCredential.user!;
      _storage.write(key: 'uid', value: user.uid);
      // print('Signed in with Apple: ${user.displayName}');
      if (userCredential.additionalUserInfo!.isNewUser) {
        await UserDatabase.createUser(user);
      }
      return null;
    } catch (error) {
      // print('Error signing in with Apple: $error');
      return 'Error signing in with Apple';
    }
  }

  static void logout(BuildContext context) async {
    await _storage.deleteAll();
    FirebaseAuth.instance.signOut();
    context.goNamed('Login');
  }
}
