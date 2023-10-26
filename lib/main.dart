import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/repositories/auth_repository.dart';
import 'package:hknance/screens/splash_screen.dart';
import 'package:hknance/view_controllers/auth_bloc/auth_bloc.dart';
import 'package:sizer/sizer.dart';

import 'utils/device_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (BuildContext context) => AuthRepository(
        firebaseAuth: FirebaseAuth.instance,
        firebaseFirestore: FirebaseFirestore.instance,
        firebaseStorage: FirebaseStorage.instance,
      ),
      child: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          authRepository: context.read<AuthRepository>(),
        ),
        child: Sizer(
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
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                    fontFamily: 'Open Sans',
                  ),
                  home: SplashScreen(),
                );
              },
              designSize:
                  isTablet(deviceType) ? Size(600, 844) : Size(390, 844),
            );
          },
        ),
      ),
    );
  }
}
