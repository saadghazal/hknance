import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';
import 'package:hknance/repositories/repositories_exports.dart';

import 'package:hknance/screens/main_screens/analysis_screen.dart';
import 'package:hknance/screens/main_screens/community_screen.dart';
import 'package:hknance/screens/profile_related_screens/profile_screen.dart';
import 'package:hknance/screens/main_screens/tips_screen.dart';

import 'package:hknance/widgets/nav_bar_widget.dart';

import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List screens = [
    const HomeScreen(),
    const AnalysisScreen(),
    const TipsScreen(),
    const CommunityScreen(),
    const ProfileScreen(),
  ];
  int currentIndex = 0;

  changeCurrentScreen(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) =>
          UserBloc(userRepository: context.read<UserRepository>())
            ..add(GetUserDataEvent()),
          lazy: false,
        ),
        BlocProvider<CommunityCubit>(
          create: (context) => CommunityCubit(communityRepository: context.read<CommunityRepository>()),
        ),
      ],
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: NavBarWidget(
          currentIndex: currentIndex,
          onTap: changeCurrentScreen,
        ),
      ),
    );
  }
}

// BottomNavigationBar(
// onTap: changeCurrentScreen,
// unselectedItemColor: AppColors.primaryDarkGrey.withOpacity(0.5),
// currentIndex: currentIndex,
// selectedItemColor: AppColors.primaryYellow,
// items: [
// BottomNavigationBarItem(
// icon: Icon(Icons.home_filled),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.recommend_rounded),
// label: 'Recommendations',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.blur_circular),
// label: 'Community',
// ),
// BottomNavigationBarItem(
// icon: Icon(Icons.account_circle_outlined),
// label: 'Profile',
// ),
// ],
// )
