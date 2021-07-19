/*
 * @Description  : http鉴权拦截器
 * @Date         : 2021-06-01 16:00:32
 * @Author       : 保锋
 * @LastEditTime : 2021-06-03 14:54:12
 * @LastEditors  : 保锋
 * @FilePath     : \xunjian_flutter\lib\utils\http\auth.dart
 */
import 'package:dio/dio.dart';

///http鉴权拦截器
class AuthInterceptor extends Interceptor {
  @override

  ///请求拦截
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    return super.onRequest(options, handler);
  }
}
