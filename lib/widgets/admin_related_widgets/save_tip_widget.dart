import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/widgets/admin_related_widgets/save_button.dart';

import '../../data_models/tip_data_model.dart';
import '../../utils/errors/error_snack_bar.dart';
import '../../view_controllers/image_picker_cubit/image_picker_cubit.dart';
import '../../view_controllers/sign_up_cubit/sign_up_cubit.dart';
import '../../view_controllers/tips_bloc/tips_bloc.dart';
import '../main_loading.dart';

class SaveTipWidget extends StatelessWidget {
  const SaveTipWidget({
    required this.isVip,
    required this.tipDescription,
    required this.tipTitle,
    required this.tipModel,
    super.key,
  });
  final TipModel? tipModel;
  final String tipTitle;
  final String tipDescription;
  final bool isVip;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return BlocConsumer<TipsBloc, TipsState>(
      listener: (context, state) {
        if (state.loadingStatus == LoadingStatus.error) {
          showErrorSnackBar(
            context: context,
            errorMessage: state.errorHandler.message,
          );
        } else if (state.loadingStatus == LoadingStatus.loaded) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return state.loadingStatus == LoadingStatus.loading
            ? Padding(
                padding: EdgeInsets.only(
                  left: 28.w,
                  right: 28.w,
                  bottom: bottomPadding == 0 ? 20.h : bottomPadding.h,
                ),
                child: const MainLoading(),
              )
            : BlocBuilder<ImagePickerCubit, ImagePickerState>(
                builder: (context, imageState) {
                  return SaveButton(
                    onTap: () async {
                      if (tipModel != null) {
                        final updatedTip = TipModel(
                          id: tipModel!.tipId,
                          tipTitle: tipTitle,
                          tipCover: tipModel!.tipCover,
                          tipDescription: tipDescription,
                          isVIP: isVip,
                          createdAt: tipModel!.createdAt,
                        );
                        context.read<TipsBloc>().add(
                              UpdateTipEvent(
                                updatedTip: updatedTip,
                              ),
                            );
                      } else {
                        context.read<TipsBloc>().add(
                              AddTipEvent(
                                title: tipTitle,
                                body: tipDescription,
                                isVIP: isVip,
                                coverFile: imageState.imageFile,
                              ),
                            );
                      }
                    },
                  );
                },
              );
      },
    );
  }
}
