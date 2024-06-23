import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppController {
  //get uid from storage
  static Future<String> getUid() async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    String? uid = await storage.read(key: 'uid');
    return uid!;
  }

  static String getGPTkeyFromEnv() {
    return dotenv.get('OPENAI_API_KEY');
  }
}
