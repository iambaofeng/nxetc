/*
 * @Description  : 登录页
 * @Date         : 2021-07-15 16:05:30
 * @Author       : 保锋
 * @LastEditTime : 2021-07-16 09:28:17
 * @LastEditors  : 保锋
 * @FilePath     : \nxetc\lib\pages\login\login_index.dart
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nxetc/widgets/appbar.dart';
import 'package:nxetc/widgets/base_scaffold.dart';

///登录页
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final LoginPageController vm = Get.put(LoginPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: BaseScaffold(
          isCanBack: true,
          isTwiceBack: true,
          appBar: MyAppBar(
            hasback: false,
            title: '',
            action: const <Widget>[RegisteredTextButton()],
          ),
          body: Container(
            width: 1.sw,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  '我的ETC，点一下',
                  style: TextStyle(fontSize: 80.sp),
                ),
                SizedBox(
                  height: 300.h,
                ),
                PasswordLogin()
              ],
            ),
          ),
        ));
  }
}

///登录页控制器
class LoginPageController extends GetxController {}

///注册按钮
class RegisteredTextButton extends StatelessWidget {
  const RegisteredTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          ///跳转到注册页
          Get.toNamed<void>('/register');
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        child: const Text('注册'));
  }
}

///密码登录模块
class PasswordLogin extends StatelessWidget {
  PasswordLogin({Key? key}) : super(key: key);
  final RxString password = ''.obs;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.9.sw,
      child: Column(
        children: <Widget>[
          TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              cursorWidth: 1,
              style: TextStyle(letterSpacing: 20.w),
              onChanged: (String value) {
                password.value = value;
              },
              decoration: const InputDecoration(
                  hintText: '请输入登录密码',
                  hintStyle: TextStyle(letterSpacing: 0),
                  border: InputBorder.none)),
          SizedBox(
            height: 20.h,
          ),
          const Divider(
            height: 1,
          ),
          SizedBox(
            height: 80.h,
          ),
          SizedBox(
            width: 0.9.sw,
            height: 120.w,
            child: Obx(() => ElevatedButton(
                onPressed: password.value.length >= 6
                    ? () {
                        ///密码登录的逻辑
                      }
                    : null,
                child: Text(
                  '登录',
                  style: TextStyle(fontSize: 50.sp),
                ))),
          ),
        ],
      ),
    );
  }
}
