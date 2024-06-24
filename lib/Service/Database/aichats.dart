import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:prepstar/Controller/controller.dart';

class ManageChats {
  //upload chat to database;
  static Future<void> uploadChat(
      String chatId, List<ChatMessage> messages) async {
    if (messages.isEmpty) {
      return;
    }
    //upload to firebase database
    String uid = await AppController.getUid();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(chatId)
        .set({
      'messages': messages.map((e) => e.toJson()).toList(),
    });
  }

  //get chat from database;
  static Future<List<String>> getChatIDs() async {
    //get all chalts from database
    String uid = await AppController.getUid();
    List<String> chatIDs = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .get()
        .then((value) {
      for (var element in value.docs) {
        chatIDs.add(element.id);
      }
    });
    return chatIDs;
  }

  //get chat from database;
  static Future<List<ChatMessage>> getChat(String chatId) async {
    //get chat from database
    String uid = await AppController.getUid();
    List<ChatMessage> messages = [];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(chatId)
        .get()
        .then((value) {
      for (var element in value.data()!['messages']) {
        messages.add(ChatMessage.fromJson(element));
      }
    });
    return messages;
  }

}
