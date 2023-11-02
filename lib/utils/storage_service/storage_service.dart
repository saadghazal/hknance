import 'dart:ui';
import 'package:get/get.dart';
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

  static Future<void> changeLanguage({required String language}) async {
    if (language == 'ar') {
      Get.updateLocale(const Locale('ar'));
    } else {
      Get.updateLocale(const Locale('en'));
    }

    await sharedPreferences.setString('lan', language);
  }

  static Future<bool> getLanguage() async {
    final language = sharedPreferences.get('lan') as String?;
    if (language != null) {
      if (language == 'ar') {
        Get.updateLocale(const Locale('ar'));
        await changeLanguage(language: 'ar');
        return true;
      } else {
        Get.updateLocale(const Locale('en'));
        await changeLanguage(language: 'en');
        return true;
      }
    } else {
      Get.updateLocale(const Locale('ar'));
      await changeLanguage(language: 'ar');
      return true;
    }
  }

}
