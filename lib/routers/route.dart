/*
 * @Description  : 主路由表
 * @Date         : 2021-05-31 14:40:37
 * @Author       : 保锋
 * @LastEditTime : 2021-07-16 14:54:12
 * @LastEditors  : 保锋
 * @FilePath     : \nxetc\lib\routers\route.dart
 */
import 'package:get/get.dart';
import 'package:nxetc/pages/home.dart';
import 'package:nxetc/pages/login/login_index.dart';
import 'package:nxetc/pages/register/register_index.dart';
import 'package:nxetc/pages/register/set_password_index.dart';

List<GetPage<dynamic>>? routes = <GetPage<dynamic>>[
  GetPage<dynamic>(name: '/login', page: () => LoginPage()),
  GetPage<dynamic>(name: '/register', page: () => RegisterPage()),
  GetPage<dynamic>(name: '/setPassword', page: () => SetPasswordPage()),
  GetPage<dynamic>(name: '/home', page: () => HomePage()),
];
