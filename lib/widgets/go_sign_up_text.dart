import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../repositories/auth_repository.dart';
import '../screens/authentication_related_screens/sign_up_screen.dart';
import '../utils/routing_animation.dart';
import '../utils/theme/app_colors.dart';
import '../view_controllers/image_picker_cubit/image_picker_cubit.dart';
import '../view_controllers/password_config_cubit/password_config_cubit.dart';
import '../view_controllers/sign_up_cubit/sign_up_cubit.dart';

class GoSignUp extends StatelessWidget {
  const GoSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontFamily: 'Open Sans',
            color: AppColors.primaryDark,
            fontSize: ScreenUtil().deviceType() ==
                DeviceType.tablet
                ? 14.sp
                : 12.sp,
          ),
          children: [
            TextSpan(
                text: 'Don\'t have an account? ',
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => openSignUpScreen(context)),
            TextSpan(
              text: 'Sign Up!',
              recognizer: TapGestureRecognizer()
                ..onTap = () => openSignUpScreen(context),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void openSignUpScreen(BuildContext context) {
  Navigator.of(context).push(
    RoutingAnimation.downToUp(
      screen: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignUpCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<PasswordConfigCubit>(
            create: (context) => PasswordConfigCubit(),
          ),
          BlocProvider<ImagePickerCubit>(
            create: (context) => ImagePickerCubit(),
          ),
        ],
        child: SignUpScreen(),
      ),
    ),
  );
}