/*
 * @Description  : 设置密码页
 * @Date         : 2021-07-16 14:35:35
 * @Author       : 保锋
 * @LastEditTime : 2021-07-16 18:18:21
 * @LastEditors  : 保锋
 * @FilePath     : \nxetc\lib\pages\register\set_password_index.dart
 */
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nxetc/utils/tools/regexp.dart';
import 'package:nxetc/widgets/appbar.dart';
import 'package:nxetc/widgets/base_scaffold.dart';
import 'package:nxetc/widgets/toast.dart';

///设置密码页
class SetPasswordPage extends StatelessWidget {
  SetPasswordPage({Key? key}) : super(key: key);
  final SetPasswordPageController vm = Get.put(SetPasswordPageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: BaseScaffold(
          appBar: MyAppBar(
            title: '设置密码',
            hasback: true,
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 30.w,
              ),

              ///新密码
              Container(
                height: 150.w,
                color: Colors.white,
                padding: EdgeInsets.only(left: 40.w, right: 40.w),
                child: Row(
                  children: <Widget>[
                    const Text('新密码'),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        textAlign: TextAlign.end,
                        cursorWidth: 1,
                        obscureText: true,
                        style: const TextStyle(letterSpacing: 4),
                        decoration: const InputDecoration(
                            hintText: '请填写新密码',
                            hintStyle: TextStyle(
                                color: Colors.black26, letterSpacing: 0),
                            border: InputBorder.none,
                            counterText: ''),
                        onChanged: (String value) {
                          vm.newPassword.value = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    )
                  ],
                ),
              ),

              const Divider(
                height: 1,
              ),

              ///确认密码
              Container(
                height: 150.w,
                color: Colors.white,
                padding: EdgeInsets.only(left: 40.w, right: 40.w),
                child: Row(
                  children: <Widget>[
                    const Text('确认密码'),
                    Expanded(
                      child: TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        textAlign: TextAlign.end,
                        cursorWidth: 1,
                        style: const TextStyle(letterSpacing: 4),
                        decoration: const InputDecoration(
                            hintText: '请确认新密码',
                            hintStyle: TextStyle(
                                color: Colors.black26, letterSpacing: 0),
                            border: InputBorder.none,
                            counterText: ''),
                        onChanged: (String value) {
                          vm.repeatPassword.value = value;
                        },
                        textInputAction: TextInputAction.next,
                      ),
                    )
                  ],
                ),
              ),

              const Divider(
                height: 1,
              ),
              SizedBox(
                height: 20.w,
              ),

              ///已阅读并同意《用户隐私政策》和《用户协议》
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: SizedBox(
                  width: 1.sw,
                  child: Text(
                    '密码必须至少8个字符，而且同时包含字母和数字',
                    style: TextStyle(color: Colors.black54, fontSize: 35.sp),
                  ),
                ),
              ),
              SizedBox(
                height: 70.h,
              ),

              ///完成按钮
              SizedBox(
                width: 1.sw,
                height: 120.w,
                child: Padding(
                  padding: EdgeInsets.only(left: 40.w, right: 40.w),
                  child: Obx(() => ElevatedButton(
                      onPressed: vm.newPassword.value.length >= 8 &&
                              vm.repeatPassword.value.length >= 8
                          ? () {
                              ///设置密码的逻辑
                              vm.checkPassword();
                            }
                          : null,
                      child: Text(
                        '保存',
                        style: TextStyle(fontSize: 50.sp),
                      ))),
                ),
              )
            ],
          ),
        ));
  }
}

///设置密码控制器
class SetPasswordPageController extends GetxController {
  ///新密码
  final RxString newPassword = ''.obs;

  ///重复密码
  final RxString repeatPassword = ''.obs;

  late FToast fToast;
  @override
  void onInit() {
    fToast = FToast();
    fToast.init(Get.context!);
    super.onInit();
  }

  ///检查密码正确性
  bool checkPassword() {
    if (!MyRegexp.isPassword(newPassword.value)) {
      fToast.removeCustomToast();
      fToast.showToast(
        child: const MyToast(
          title: '新密码输入有误',
          type: MyToastType.info,
        ),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
      return false;
    } else if (newPassword != repeatPassword) {
      fToast.removeCustomToast();
      fToast.showToast(
        child: const MyToast(
          title: '两个密码不一致',
          type: MyToastType.info,
        ),
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 2),
      );
      return false;
    } else {
      return true;
    }
  }
}
