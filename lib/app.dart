import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:textile/config/theme/theme.dart';
import 'package:textile/constants/app_constants.dart';
import 'package:textile/screens/auth/sign_in.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Material nav keyf
  static GlobalKey<NavigatorState> materialNavKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      navigatorKey: materialNavKey,
      theme: ThemeConfig.theme(),
      debugShowCheckedModeBanner: false,
      builder: (_, child) {
        return ScreenUtilInit(builder: (_,__) =>  child!);
        },
      home: const SignIn(),
    );
  }
}
