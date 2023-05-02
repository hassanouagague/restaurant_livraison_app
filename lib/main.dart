import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_livraison_app/view/auth/login.dart';
import 'package:get/get.dart';

import 'package:food_livraison_app/routes/route_constant.dart';
import 'package:food_livraison_app/routes/routes.dart';

import 'bindings/bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyBin().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          //getPages: ,
          getPages: Routes.route,
          builder: EasyLoading.init(),
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.blue,
            //textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(18.0),
              ),
            ),
          ),
          initialRoute: RouteConstant.splash,
        );
      },
    );
  }
}
