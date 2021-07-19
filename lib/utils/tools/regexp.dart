/*
 * @Description  : 正则表达式
 * @Date         : 2021-06-24 09:00:26
 * @Author       : 保锋
 * @LastEditTime : 2021-07-16 18:12:50
 * @LastEditors  : 保锋
 * @FilePath     : \nxetc\lib\utils\tools\regexp.dart
 */

///正则验证类
class MyRegexp {
  ///8位密码验证
  static bool isPassword(String str) {
    final RegExp password =
        RegExp(r'^(?![a-zA-Z]+$)(?![0-9]+$)[a-zA-Z0-9]{8,}$');
    return password.hasMatch(str);
  }

  ///6位手机验证码
  static bool isValidateCaptcha(String input) {
    final RegExp mobile = RegExp(r'\d{6}$');
    return mobile.hasMatch(input);
  }

  ///手机号验证
  static bool isChinaPhoneLegal(String str) {
    return RegExp(
            r'^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$')
        .hasMatch(str);
  }

  ///邮箱验证
  static bool isEmail(String str) {
    return RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$')
        .hasMatch(str);
  }

  ///验证URL
  static bool isUrl(String value) {
    return RegExp(r'^((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+').hasMatch(value);
  }

  ///验证身份证
  static bool isIdCard(String value) {
    return RegExp(r'\d{17}[\d|x]|\d{15}').hasMatch(value);
  }

  ///验证中文
  static bool isChinese(String value) {
    return RegExp(r'[\u4e00-\u9fa5]').hasMatch(value);
  }
}
