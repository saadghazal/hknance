import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/repositories/auth_repository.dart';
import 'package:hknance/screens/admin_related_screens/admin_news_screen.dart';
import 'package:hknance/screens/admin_related_screens/admin_profile_screen.dart';
import 'package:hknance/screens/admin_related_screens/admin_tips_screen.dart';
import 'package:hknance/view_controllers/sign_out_cubit/sign_out_cubit.dart';
import 'package:hknance/widgets/nav_bar_widget.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int currentIndex = 0;
  List<Widget> adminScreens = [
    AdminNewsScreen(),
    AdminTipsScreen(),
    AdminProfileScreen(),
  ];

  changeCurrentScreen(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Admin Main Screen Disposed');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SignOutCubit(authRepository: context.read<AuthRepository>()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Image.asset(
            'assets/logo/hknance_logo.jpg',
            height: 70.h,
          ),
          centerTitle: true,
          toolbarHeight:
              ScreenUtil().deviceType() == DeviceType.tablet ? 70.h : 40.h,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
          ),
        ),
        body: adminScreens[currentIndex],
        bottomNavigationBar: NavBarWidget(
          currentIndex: currentIndex,
          onTap: changeCurrentScreen,
          isAdmin: true,
        ),
      ),
    );
  }
}
