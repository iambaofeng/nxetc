/*
 * @Description  : 顶部标题栏
 * @Date         : 2021-06-16 08:42:54
 * @Author       : 保锋
 * @LastEditTime : 2021-07-15 17:26:21
 * @LastEditors  : 保锋
 * @FilePath     : \nxetc\lib\widgets\appbar.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

///自定义标题栏
///
///[key]设置唯一的key
///
///[title]中间的标题
///
///[action]右侧自定义的动作小组件
///
///[hasback]是否有返回按钮
///
///[color]颜色
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar(
      {Key? key,
      required this.title,
      this.leading,
      this.action,
      this.hasback = true,
      this.elevation = 0.0,
      this.handelBack,
      this.backgroundColor})
      : preferredSize = Size.fromHeight(120.w),
        super(key: key);

  ///标题
  final String title;

  ///标题栏高度
  @override
  final Size preferredSize;

  final Widget? leading;

  ///阴影的长度
  final double elevation;

  ///右侧动作槽
  final List<Widget>? action;

  ///是否有返回键
  final bool? hasback;

  ///标题栏的颜色
  final Color? backgroundColor;

  ///返回按钮的回调函数
  final void Function()? handelBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      elevation: elevation,
      backgroundColor: backgroundColor,
      actions: action,
      leading: leading ??
          (hasback == true
              ? BackButton(
                  handelBack: handelBack,
                )
              : null),
    );
  }
}

///返回按钮
class BackButton extends StatelessWidget {
  const BackButton({Key? key, this.handelBack}) : super(key: key);

  final void Function()? handelBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.black,
      ),
      onPressed: handelBack ??
          () {
            Get.back<dynamic>();
          },
    );
  }
}
