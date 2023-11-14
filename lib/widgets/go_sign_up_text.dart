import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';
import '../repositories/auth_repository.dart';
import '../screens/authentication_related_screens/sign_up_screen.dart';
import '../utils/routing_animation.dart';
import '../utils/theme/app_colors.dart';


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
                text: 'no_account_desc'.tr,
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => openSignUpScreen(context)),
            TextSpan(
              text: 'sign_up_account'.tr,
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
