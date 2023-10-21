import 'package:flutter/material.dart';

import '../screens/post_related_screens/add_post_screen.dart';

class RoutingAnimation {
  static Route downToUp({required Widget screen}) {
    return PageRouteBuilder(
      pageBuilder: (
        context,
        primary,
        secondary,
      ) {
        return screen;
      },
      transitionsBuilder: (context, primary, secondary, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = primary.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
    );
  }

  static Route fade({required Widget screen}) {
    return PageRouteBuilder(
      pageBuilder: (context, primary, secondary) {
        return screen;
      },
      transitionsBuilder: (
        context,
        primary,
        secondary,
        child,
      ) {
        const begin = 0.5;
        const end = 1.0;
        final tween = Tween<double>(begin: begin, end: end);
        final offsetAnimation = primary.drive(tween);

        return FadeTransition(
          opacity: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
