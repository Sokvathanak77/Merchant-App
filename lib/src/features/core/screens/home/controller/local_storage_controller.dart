import 'dart:ffi';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends GetxService{
  static LocalStorage get to => Get.find();
  late final SharedPreferences _prefs;

//set method
  Future<LocalStorage> init() async{
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setString(String key, String value) async{
    return await _prefs.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async{
    return await _prefs.setBool(key, value);
  }

  Future<bool> setList(String key, List<String> value) async{
    return await _prefs.setStringList(key, value);
  }
  Future<bool> setDouble(String key, double value) async{
    return await _prefs.setDouble(key, value);
  }

//get method
  String getString(String key){
    return _prefs.getString(key) ?? "";
  }

  bool getBool(String key){
    return _prefs.getBool(key) ?? false;
  }

  List getList(String key){
    return _prefs.getStringList(key) ?? [];
  }
  
  double getDouble(String key){
    return _prefs.getDouble(key) ?? 0.0;
  }

  Future<bool> remove(String key) async{
    return await _prefs.remove(key);
  }
   
}