import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/screens/main_screens/main_screen.dart';
import 'package:hknance/screens/splash_screen.dart';
import 'package:sizer/sizer.dart';

import 'utils/device_type.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, deviceType) {
        return ScreenUtilInit(
          ensureScreenSize: true,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, _) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.white,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                // useMaterial3: true,

                fontFamily: 'Open Sans',
              ),
              home: SplashScreen(),
            );
          },
          designSize: isTablet(deviceType) ? Size(600, 844) : Size(390, 844),
        );
      },
    );
  }
}
