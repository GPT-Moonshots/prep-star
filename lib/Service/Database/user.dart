import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prepstar/Controller/controller.dart';
import 'package:prepstar/Model/user_model.dart';
import 'package:uuid/uuid.dart';

class UserDatabase {
  static createUser(User user) {
    String uid = user.uid;
    Uuid uuid = const Uuid();
    UserModel userModel = UserModel(
      email: user.email!,
      uid: uid,
      username: uuid.v4(),
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel.toMap());
  }

  static Future<UserModel?> getUser() async {
    String? uid = await AppController.getUid();
    try {
      UserModel? user;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) {
        user = UserModel.fromMap(value.data()!);
      });
      log(user!.email);
      return user!;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
