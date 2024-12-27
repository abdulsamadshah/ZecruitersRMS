
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zecruiters_rms/core/constant/SecureSharedPref.dart';



class StorageServices {
  late final SharedPreferences _prefs;

  Future<StorageServices> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }
  Future<bool> getBool(String key) async {
    return _prefs.getBool(key)??false;
  }
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }



  String? getaccesstoken() {
    return _prefs.getString(SecureSharedPreference.deviceToken);
  }




  String? getDevice_id() {
    return _prefs.getString(SecureSharedPreference.deviceToken);
  }




  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }





  String? get(String key) {
    return _prefs.getString(key);
  }
}
