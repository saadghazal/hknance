import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<String?> getUserId() async {
    return sharedPreferences.getString('user_id');
  }

  static Future<void> setUserId({required String userId}) async {
    await sharedPreferences.setString(
      'user_id',
      userId,
    );
  }
}
