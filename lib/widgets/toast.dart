/*
 * @Description  : 自定义弹窗
 * @Date         : 2021-07-16 17:05:02
 * @Author       : 保锋
 * @LastEditTime : 2021-07-16 17:42:23
 * @LastEditors  : 保锋
 * @FilePath     : \nxetc\lib\widgets\toast.dart
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///自定义toast内容体
class MyToast extends StatelessWidget {
  const MyToast(
      {Key? key,
      this.title = '',
      this.type = MyToastType.info,
      this.backgroundColor = Colors.black87,
      this.color = Colors.white})
      : super(key: key);

  ///内容
  final String? title;

  ///类型
  final MyToastType? type;

  ///背景颜色
  final Color? backgroundColor;

  ///图标及文字颜色
  final Color? color;

  @override
  Widget build(BuildContext context) {
    IconData getIcon() {
      switch (type) {
        case MyToastType.info:
          return Icons.info;
        case MyToastType.error:
          return Icons.highlight_off;
        case MyToastType.success:
          return Icons.check_circle_outline;
        default:
          return Icons.info;
      }
    }

    return TweenAnimationBuilder<double>(
        curve: Curves.easeInOutBack,
        tween: Tween<double>(begin: 0.1, end: 1.0),
        duration: const Duration(milliseconds: 500),
        builder: (BuildContext context, double value, Widget? child) {
          return Container(
            width: 500.w * value,
            height: 300.w * value,
            decoration: BoxDecoration(color: backgroundColor),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40.w * value,
                ),
                Icon(
                  getIcon(),
                  color: color,
                  size: 90.w * value,
                ),
                SizedBox(
                  height: 30.w * value,
                ),
                Text(
                  title!,
                  style: TextStyle(color: color, fontSize: 42.sp * value),
                )
              ],
            ),
          );
        });
  }
}

enum MyToastType { info, error, success }
