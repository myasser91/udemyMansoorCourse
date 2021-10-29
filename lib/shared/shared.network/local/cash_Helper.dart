// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper {
  static SharedPreferences? prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static dynamic getdata({required String key}) {
    return prefs!.get(key);
  }

  static Future<bool> savedata({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await prefs!.setString(key, value);
    if (value is int) return await prefs!.setInt(key, value);
    if (value is bool) return await prefs!.setBool(key, value);

    return await prefs!.setDouble(key, value);
  }


   static Future<bool> removedata({required String key}){
  return CashHelper.prefs!.remove(key);
   }
}