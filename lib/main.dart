import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/repositories/auth_repository.dart';
import 'package:hknance/repositories/community_repository.dart';
import 'package:hknance/repositories/news_repository.dart';
import 'package:hknance/repositories/tips_repository.dart';
import 'package:hknance/repositories/user_repository.dart';
import 'package:hknance/screens/splash_screen.dart';
import 'package:hknance/utils/storage_service/storage_service.dart';
import 'package:hknance/view_controllers/auth_bloc/auth_bloc.dart';
import 'package:hknance/view_controllers/news_bloc/news_bloc.dart';
import 'package:hknance/view_controllers/tips_bloc/tips_bloc.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';
import 'utils/device_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (BuildContext context) => AuthRepository(
            firebaseAuth: FirebaseAuth.instance,
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => CommunityRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => NewsRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => TipsRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseStorage: FirebaseStorage.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => NewsBloc(
              newsRepository: context.read<NewsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => TipsBloc(
              tipsRepository: context.read<TipsRepository>(),
            ),
          ),
        ],
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
                  home: const SplashScreen(),
                );
              },
              designSize: isTablet(deviceType)
                  ? const Size(600, 844)
                  : const Size(390, 844),
            );
          },
        ),
      ),
    );
  }
}
