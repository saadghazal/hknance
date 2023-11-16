import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/view_controllers/contorllers_exports.dart';

import 'package:hknance/widgets/admin_related_widgets/save_button.dart';

import '../../data_models/tip_data_model.dart';
import '../../utils/errors/error_snack_bar.dart';
import '../main_loading.dart';

class SaveTipWidget extends StatelessWidget {
  const SaveTipWidget({
    required this.isVip,
    required this.tipDescription,
    required this.tipTitle,
    required this.tipModel,
    required this.tipAdvice,
    super.key,
  });
  final TipModel? tipModel;
  final String tipTitle;
  final String tipDescription;
  final String tipAdvice;
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
                  top: 10.h,
                  bottom: bottomPadding == 0 ? 20.h : bottomPadding.h,
                ),
                child: const MainLoading(),
              )
            : BlocBuilder<ImagePickerCubit, ImagePickerState>(
                builder: (context, imageState) {
                  return BlocBuilder<TipCategoriesCubit, TipCategoriesState>(
                    builder: (context, tipCategoriesState) {
                      return BlocBuilder<TipTypeCubit, TipTypeState>(
                        builder: (context, tipTypeState) {
                          return SaveButton(
                            onTap: () async {
                              if (tipModel != null) {
                                final updatedTip = TipModel(
                                  id: tipModel!.tipId,
                                  tipTitle: tipTitle,
                                  tipCover: tipModel!.tipCover,
                                  tipDescription: tipDescription,
                                  isVIP: tipModel!.isVIP,
                                  tipTypeModel: TipTypeModel(
                                    type: tipTypeState.selectedTipText,
                                    adviceTitle: tipAdvice,
                                  ),
                                  tipCategories:
                                      tipCategoriesState.tipCategories,
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
                                        tipType: tipTypeState.selectedTipText,
                                        tipAdvice: tipAdvice,
                                        categories:
                                            tipCategoriesState.tipCategories,
                                        coverFile: imageState.imageFile,
                                      ),
                                    );
                                await context
                                    .read<NotificationsCubit>()
                                    .sendNotification(
                                      isVIP: isVip,
                                      tipCategories:
                                          tipCategoriesState.tipCategories,
                                      tipType: tipTypeState.selectedTipText,
                                      tipAdvice: tipAdvice,
                                    );
                              }
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
      },
    );
  }
}
