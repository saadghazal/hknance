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

  static Future<void> setIsAdmin({required bool isAdmin}) async {
    await sharedPreferences.setBool(
      'is_admin',
      isAdmin,
    );
  }

  static bool? getIsAdmin()  {
    return sharedPreferences.getBool('is_admin');
  }

}
