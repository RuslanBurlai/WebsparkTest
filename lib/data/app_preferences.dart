import 'package:shared_preferences/shared_preferences.dart';
import 'package:webspark_test/core/constants.dart';

class AppPreference {

  final SharedPreferences _sharedPreferences;

  AppPreference(this._sharedPreferences);

  Future<String> get apiUrl async => _sharedPreferences.getString(userURL) ?? '';
  Future<void> saveUserURL(String text) async => await _sharedPreferences.setString(userURL, text); 

}