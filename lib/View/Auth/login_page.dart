import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:prepstar/Service/Auth/auth.dart';
import 'package:prepstar/Service/Auth/o_auth.dart';

import 'constants.dart';
import 'custom_route.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  const LoginScreen({super.key});

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData loginData) async {
    return await AuthServices.signInWithEmailPassword(
        loginData.name, loginData.password);
  }

  Future<String?> _signupUser(SignupData data) async {
    return await AuthServices.signUpWithEmailPassword(
        data.name!, data.password!);
  }

  Future<String?> _recoverPassword(String name) async {
    return await AuthServices.resetPassword(name);
  }

  @override
  Widget build(BuildContext context) {
    final theme = LoginTheme(
      titleStyle: GoogleFonts.caveat(
        textStyle: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );

    return FlutterLogin(
      title: Constants.appName,
      theme: theme,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      loginAfterSignUp: true,
      loginProviders: [
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            String? authSuccessfull = await OauthService.signInWithGoogle();

            if (authSuccessfull == null) {
              FlutterSecureStorage storage = const FlutterSecureStorage();
              String? uid = await storage.read(key: 'uid');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Placeholder()),
              );
              return null;
            } else {
              return 'Sign-in with Google failed';
            }
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.apple,
          label: 'Apple',
          callback: () async {
            String? authSuccessfull = await OauthService.signInWithApple();
            if (authSuccessfull == null) {
              FlutterSecureStorage storage = const FlutterSecureStorage();
              String? uid = await storage.read(key: 'uid');
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Placeholder()),
              );
              return null;
            } else {
              return 'Sign-in with Apple failed';
            }
          },
        ),
      ],
      userValidator: (value) {
        if (!value!.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        return _loginUser(loginData);
      },
      onSignup: (signupData) async {
        return _signupUser(signupData);
      },
      onSubmitAnimationCompleted: () async {
        FlutterSecureStorage storage = const FlutterSecureStorage();
        String? uid = await storage.read(key: 'uid');
        Navigator.of(context).pushReplacement(
          FadePageRoute(
            builder: (context) => Placeholder(),
          ),
        );
      },
      onRecoverPassword: (name) {
        // debugPrint('Recover password info');
        // debugPrint('Name: $name');
        return _recoverPassword(name);
      },
      headerWidget: const IntroWidget(),
    );
  }
}

class IntroWidget extends StatelessWidget {
  const IntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Authenticate"),
            ),
            Expanded(child: Divider()),
          ],
        ),
      ],
    );
  }
}
