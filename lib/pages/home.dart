/*
 * @Description  : 首页
 * @Date         : 2021-07-15 09:24:49
 * @Author       : 保锋
 * @LastEditTime : 2021-07-15 09:25:21
 * @LastEditors  : 保锋
 * @FilePath     : \nxetc\lib\pages\home.dart
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final HomePageController vm = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return const Text('测试页');
  }
}

class HomePageController extends GetxController {}
