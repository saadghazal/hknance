import 'package:flutter/material.dart';
import 'package:hknance/screens/admin_related_screens/admin_news_screen.dart';
import 'package:hknance/screens/admin_related_screens/admin_profile_screen.dart';
import 'package:hknance/screens/admin_related_screens/admin_tips_screen.dart';
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
  changeCurrentScreen(int index){
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: adminScreens[currentIndex],
      bottomNavigationBar: NavBarWidget(
        currentIndex: currentIndex,
        onTap: changeCurrentScreen,
        isAdmin: true,
      ),
    );
  }
}
