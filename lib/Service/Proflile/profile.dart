import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prepstar/Model/user_model.dart';

class UserProfile {
  //get user from uid
  Future<UserModel> getUser(String uid) async {
    UserModel? user;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      user = UserModel.fromMap(value.data()!);
    });
    return user!;
  }
}
