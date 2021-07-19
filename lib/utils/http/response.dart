/*
 * @Description  : http返回拦截器
 * @Date         : 2021-06-01 16:00:38
 * @Author       : 保锋
 * @LastEditTime : 2021-06-03 14:47:44
 * @LastEditors  : 保锋
 * @FilePath     : \xunjian_flutter\lib\utils\http\response.dart
 */
import 'package:dio/dio.dart';
// import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

///响应拦截器
class ResponseInterceptors extends Interceptor {
  @override

  ///响应拦截
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    // RequestOptions option = response.requestOptions;
    // final data = response.data;
    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {
      // SmartDialog.showToast(response.data["msg"]);
    }
    return super.onResponse(response, handler);
  }
}

///错误编码
class Code {
  ///网络错误
  static const int NETWORK_ERROR = -1;

  ///网络超时
  static const int NETWORK_TIMEOUT = -2;

  ///网络返回数据格式化一次
  static const int NETWORK_JSON_EXCEPTION = -3;

  static const int SUCCESS = 200;
}
