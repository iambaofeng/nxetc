/*
 * @Description  : 注册页
 * @Date         : 2021-07-16 09:22:20
 * @Author       : 保锋
 * @LastEditTime : 2021-07-16 14:44:06
 * @LastEditors  : 保锋
 * @FilePath     : \nxetc\lib\pages\register\register_index.dart
 */
import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nxetc/utils/tools/regexp.dart';
import 'package:nxetc/widgets/appbar.dart';
import 'package:nxetc/widgets/base_scaffold.dart';

///注册页
class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final RegisterPageController vm = Get.put(RegisterPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: BaseScaffold(
          appBar: MyAppBar(
            title: '用户注册',
            hasback: true,
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 30.w,
              ),
              Container(
                height: 150.w,
                color: Colors.white,
                padding: EdgeInsets.only(left: 40.w, right: 40.w),
                child: TextFormField(
                    keyboardType: TextInputType.phone,
                    cursorWidth: 1,
                    decoration: const InputDecoration(
                        hintText: '请输入手机号码',
                        hintStyle: TextStyle(color: Colors.black26),
                        border: InputBorder.none,
                        counterText: ''),
                    onChanged: (String value) {
                      vm.phone.value = value;
                    },
                    textInputAction: TextInputAction.next,
                    maxLength: 11),
              ),
              const Divider(
                height: 1,
              ),

              ///短信验证码
              Container(
                height: 150.w,
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 40.w,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            cursorWidth: 1,
                            style: const TextStyle(letterSpacing: 3),
                            decoration: const InputDecoration(
                                hintText: '请输入短信验证码',
                                hintStyle: TextStyle(
                                    color: Colors.black26, letterSpacing: 0),
                                border: InputBorder.none,
                                counterText: ''),
                            onChanged: (String value) {
                              vm.code.value = value;
                            },
                            maxLength: 6)),
                    Container(
                      height: 100.w,
                      width: 1,
                      color: Colors.black12,
                    ),
                    SizedBox(
                      width: 300.w,
                      child: Center(child: Obx(() {
                        if (vm.codeSecond.value > 0) {
                          return Text(
                            '${vm.codeSecond.value}S后重新获取',
                            style: TextStyle(fontSize: 35.sp),
                          );
                        } else {
                          return TextButton(
                            onPressed:
                                MyRegexp.isChinaPhoneLegal(vm.phone.value)
                                    ? () {
                                        ///如果手机号合法，则发送短信验证码可用
                                        ///
                                        vm.getCode();
                                      }
                                    : null,
                            child: Text(
                              '获取验证码',
                              style: TextStyle(
                                  fontSize: 38.sp, fontWeight: FontWeight.w600),
                            ),
                          );
                        }
                      })),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),

              ///已阅读并同意《用户隐私政策》和《用户协议》
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: SizedBox(
                  height: 100.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Obx(() => SizedBox(
                            width: 70.w,
                            // height: 40.w,
                            child: Transform(
                              alignment: Alignment.centerLeft,
                              transform: Matrix4.identity()..scale(0.7, 0.7),
                              child: Checkbox(
                                  value: vm.isCheck.value,
                                  onChanged: (bool? value) {
                                    vm.isCheck.toggle();
                                  }),
                            ),
                          )),
                      RichText(
                          text: TextSpan(
                              text: '已阅读并同意',
                              style: TextStyle(
                                  fontSize: 35.sp, color: Colors.black),
                              children: <InlineSpan>[
                            TextSpan(
                                text: '《用户隐私政策》',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    ///路由跳转到用户隐私政策页
                                    print('用户隐私政策页');
                                  }),
                            const TextSpan(text: '和'),
                            TextSpan(
                                text: '《用户协议》',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    ///路由跳转到用户协议
                                    print('用户协议');
                                  })
                          ]))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 70.h,
              ),

              ///注册按钮
              SizedBox(
                width: 0.9.sw,
                height: 120.w,
                child: Obx(() => ElevatedButton(
                    onPressed: MyRegexp.isChinaPhoneLegal(vm.phone.value) &&
                            MyRegexp.isValidateCaptcha(vm.code.value) &&
                            vm.isCheck.value
                        ? () {
                            ///注册的逻辑
                          }
                        : null,
                    child: Text(
                      '注册',
                      style: TextStyle(fontSize: 50.sp),
                    ))),
              )
            ],
          ),
        ));
  }
}

///注册页控制器
class RegisterPageController extends GetxController {
  ///注册手机号
  final RxString phone = ''.obs;

  ///验证码倒计时
  final RxInt codeSecond = 0.obs;

  ///是否同意用户协议和用户隐私政策
  final RxBool isCheck = false.obs;

  ///验证码
  final RxString code = ''.obs;

  ///验证码定时器
  late Timer timer;

  ///获取验证码
  void getCode() {
    ///1.开启60s倒计时
    codeSecond.value = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (codeSecond.value > 0) {
        codeSecond.value--;
      } else {
        timer.cancel();
      }
    });

    ///2.调用短信验证码
  }
}
