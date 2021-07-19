/*
 * @Description  : http请求基础类
 * @Date         : 2021-06-01 15:58:58
 * @Author       : 保锋
 * @LastEditTime : 2021-06-03 17:40:49
 * @LastEditors  : 保锋
 * @FilePath     : \xunjian_flutter\lib\utils\http\http.dart
 */
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import '/config/config.dart';
import '/utils/http/auth.dart';
import '/utils/http/log.dart';
import '/utils/http/proxy.dart';
import '/utils/http/response.dart';

///网络请求基础类
class Http {
  factory Http() => _instance;

  ///构造函数

  Http._init() {
    _options = BaseOptions(

        ///基础url
        baseUrl: Config.BASE_URL,

        ///连接超时时间
        connectTimeout: _CONNECTTIMEOUT,

        ///返回超时时间
        receiveTimeout: _RECEIVETIMEOUT,

        ///设置请求头
        headers: <String, dynamic>{'resource': 'android'},

        ///默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
        contentType: Headers.formUrlEncodedContentType,

        ///共有三种方式json,bytes(响应字节),stream（响应流）,plain
        responseType: ResponseType.json);
    _dio = Dio(_options);

    ///设置Cookie
    _dio.interceptors.add(CookieManager(CookieJar()));

    ///添加日志拦截器
    _dio.interceptors.add(HttpLog());

    ///添加请求头拦截器
    _dio.interceptors.add(AuthInterceptor());

    ///添加返回拦截器
    _dio.interceptors.add(ResponseInterceptors());

    ///是否启用代理
    /// 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
    if (Proxy.PROXY_ENABLE) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.findProxy = (Uri uri) {
          return 'PROXY $Proxy.PROXY_IP:$Proxy.PROXY_PORT';
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  ///超时时间 (默认10秒)
  static const int _CONNECTTIMEOUT = 10000;

  ///返回时间（默认3秒）
  static const int _RECEIVETIMEOUT = 3000;

  //单例模式
  static final Http _instance = Http._init();

  ///dio实例
  late Dio _dio;

  ///http基础配置
  late BaseOptions _options;

  ///get请求
  ///
  ///[url]api地址，[data]请求参数,[options]请求配置，[cancelToken]取消令牌
  dynamic get(String url,
      {Map<String, dynamic>? data,
      Options? options,
      CancelToken? cancelToken}) async {
    late Response<dynamic> response;
    try {
      response = await _dio.get<dynamic>(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
    } on DioError {
      // print(e);
    }
    return response.data;
  }

  ///post请求
  ///
  ///[url]api地址，[data]请求参数,[options]请求配置，[cancelToken]取消令牌
  dynamic post(String url,
      {dynamic data,
      Options? options,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken}) async {
    late Response<dynamic> response;

    try {
      Options? optionsNew;
      optionsNew = options ?? Options(contentType: 'application/json');
      response = await _dio.post<dynamic>(url,
          data: data,
          options: optionsNew,
          queryParameters: queryParameters,
          cancelToken: cancelToken);
    } on DioError {
      //
    }
    return response.data;
  }

  ///delete请求
  ///
  ///[url]api地址，[data]请求参数,[options]请求配置，[cancelToken]取消令牌
  dynamic delete(String url,
      {dynamic data,
      Options? options,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken}) async {
    late Response<dynamic> response;

    try {
      Options? optionsNew;
      optionsNew = options ?? Options(contentType: 'application/json');
      response = await _dio.delete<dynamic>(url,
          data: data,
          options: optionsNew,
          queryParameters: queryParameters,
          cancelToken: cancelToken);
    } on DioError {
      //
    }
    return response.data;
  }

  ///put请求
  ///
  ///[url]api地址，[data]请求参数,[options]请求配置，[cancelToken]取消令牌
  dynamic put(String url,
      {dynamic data,
      Options? options,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken}) async {
    late Response<dynamic> response;

    try {
      Options? optionsNew;
      optionsNew = options ??
          Options(
            contentType: 'application/json',
          );
      response = await _dio.put<dynamic>(url,
          data: data,
          options: optionsNew,
          queryParameters: queryParameters,
          cancelToken: cancelToken);
    } on DioError {
      //
    }
    return response.data;
  }

  ///Form请求
  ///
  ///[url]api地址，[data]请求参数,[options]请求配置，[cancelToken]取消令牌
  dynamic postForm(String url,
      {dynamic data,
      Options? options,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken}) async {
    late Response<dynamic> response;
    try {
      response = await _dio.post<dynamic>(url,
          data: data, options: options, cancelToken: cancelToken);
    } on DioError {
      //
    }
    return response.data;
  }

  ///下载文件
  dynamic downLoadFile(String urlPath, dynamic savePath) async {
    late Response<dynamic> response;
    try {
      response = await _dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        print('$count $total');
      });
    } on DioError {
      //
    }
    return response.data;
  }

  ///取消请求
  void cancleRequests(CancelToken token) {
    token.cancel('cancelled');
  }
}
