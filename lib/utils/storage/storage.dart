/*
 * @Description  : 本地缓存服务
 * @Date         : 2021-06-22 16:14:03
 * @Author       : 保锋
 * @LastEditTime : 2021-06-22 16:19:16
 * @LastEditors  : 保锋
 * @FilePath     : \knowledge_contest\lib\services\storage_services.dart
 */
import 'package:shared_preferences/shared_preferences.dart';

///本地缓存服务
class Storage {
  ///设置键值对
  ///
  ///[key]键
  ///
  ///[value]值
  static Future<void> setString(String key, String value) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  ///读取键值对
  ///
  ///[key]键
  static Future<String?> getString(String key) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.containsKey(key)) {
      return sp.getString(key);
    } else {
      return null;
    }
  }

  ///清除所有的键值对
  static Future<void> clear() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  ///清除指定的键值对
  ///
  ///[key]键
  static Future<void> remove(String key) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }
}
