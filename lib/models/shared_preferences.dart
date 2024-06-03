import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static final String _key = "type";
  static final String _email = "email";
  static final String _name = "name";
  static final String token = "token";
  static final String image = 'image';
  //for worker type
  static Future<void> saveData(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString(_key, value);
    print(
        success); // This will print true if the value was successfully saved, false otherwise
  }

  static Future<void> saveImage(String value) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString(image, value);
    print(success);
  }

  static Future<String?> getImage() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(image);
  }

  static Future<String?> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(_key));
    return prefs.getString(_key);
  }

  //for token
  static Future<void> saveToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString(token, value);
    print(success);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(token));
    return prefs.getString(token);
  }

  //for name
  static Future<void> saveName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString(_name, value);
    print(success);
  }

  static Future<String?> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(_name));
    return prefs.getString(_name);
  }

  //for email

  static Future<void> saveEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString(_email, value);
    print(success);
  }

  static Future<String?> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(_email));
    return prefs.getString(_email);
  }
}
