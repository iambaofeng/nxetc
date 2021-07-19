/*
 * @Description  : 主函数
 * @Date         : 2021-07-15 09:14:08
 * @Author       : 保锋
 * @LastEditTime : 2021-07-15 16:14:34
 * @LastEditors  : 保锋
 * @FilePath     : \nxetc\lib\main.dart
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nxetc/routers/route.dart';

Future<void> main() async {
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: () => GetMaterialApp(
        ///关闭右上角测试条
        debugShowCheckedModeBanner: false,

        title: '宁夏ETC',

        ///绑定路由表
        getPages: routes,

        ///设置全局主题
        theme: ThemeData(primaryColor: Colors.white),

        ///国际化设置（解决长按TextFiled出现英文（复制、粘贴）的问题）
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale('zh', 'CN'),
          Locale('en', 'US'),
        ],

        ///全局配置空白处点击取消输入框焦点
        builder: (BuildContext context, Widget? child) {
          return GestureDetector(
            onTap: () {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
              // SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: child,
          );
        },

        ///设置初始化路由页面
        initialRoute: '/setPassword',
      ),
    );
  }
}

/// 在你运行Flutter应用之前，让你的服务初始化是一个明智之举。
////因为你可以控制执行流程（也许你需要加载一些主题配置，apiKey，由用户自定义的语言等，所以在运行ApiService之前加载SettingService。
///所以GetMaterialApp()不需要重建，可以直接取值。
Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ///加载用户信息服务
  // await Get.putAsync(() => UserService().init());

  // ///加载玩家服务
  // await Get.putAsync(() => PlayerService().init());

  // ///加载极光推送服务
  // await Get.putAsync(() => PushService().init());

  // ///加载ota自动升级服务
  // await Get.putAsync(() => OtaService().init());
}
