import 'package:shared_preferences/shared_preferences.dart';

class sharedMethod{

  static String logInKey = "IsLogIn";
  static String nameKey = "NameKey";
  static String emailKey = "EmailKey";

  static Future<void> setLogInPreference(bool isLogIn) async{

    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setBool(logInKey, isLogIn);
  }

  static Future<void> setNamePreference(String name) async{

    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(nameKey, name);
  }

  static Future<void> setEmailPreference(String email) async{

    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.setString(emailKey, email);
  }

    static Future<bool> getLogInPreference() async{

    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getBool(logInKey);
  }

  static Future<String> getNamePreference() async{

    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(nameKey);
  }

  static Future<String> getEmailPreference() async{

    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(emailKey);
  }

}