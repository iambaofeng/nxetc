/*
 * @Description  : http请求日志拦截器
 * @Date         : 2021-06-01 16:00:15
 * @Author       : 保锋
 * @LastEditTime : 2021-07-15 09:31:34
 * @LastEditors  : 保锋
 * @FilePath     : \nxetc\lib\utils\http\log.dart
 */
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '/utils/http/error.dart';

///http日志拦截器
class HttpLog extends Interceptor {
  @override

  ///请求日志
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('[-----请求分割线-----]');
    print('请求baseUrl：${options.baseUrl}');
    print('请求url：${options.path}');
    print('请求方法：${options.method}');
    print('请求头: ' + options.headers.toString());
    if (options.data != null && options.contentType != 'multipart/form-data') {
      print('请求体: ' + json.encode(options.data));
    }
    print('请求参数：' + options.queryParameters.toString());
    return super.onRequest(options, handler);
  }

  @override

  ///返回日志
  void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    print('[----------返回分割线----------]');
    print('请求url：' + response.requestOptions.path);
    print('响应状态码：' + response.statusCode.toString());
    print('响应消息：' + response.statusMessage.toString());
    print('响应体：' + json.encode(response.data));
    return super.onResponse(response, handler);
  }

  @override

  ///错误日志
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //error统一处理
    final AppException appException = AppException.create(err);
    // 错误提示
    print('[------------------错误分割线----------------]');
    debugPrint('请求url： ${err.requestOptions.path}');
    debugPrint('请求异常: ${appException.toString()}');
    err.error = appException;
    return super.onError(err, handler);
  }
}
