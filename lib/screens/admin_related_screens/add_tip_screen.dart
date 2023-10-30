import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/tip_data_model.dart';
import 'package:hknance/utils/errors/error_snack_bar.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';
import 'package:hknance/view_controllers/tips_bloc/tips_bloc.dart';
import 'package:hknance/widgets/admin_related_widgets/add_cover_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/delete_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/save_button.dart';
import 'package:hknance/widgets/admin_related_widgets/tip_type_selection_widget.dart';

import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_texts.dart';
import '../../view_controllers/image_picker_cubit/image_picker_cubit.dart';
import '../../widgets/main_app_bar.dart';
import '../../widgets/main_loading.dart';
import '../../widgets/main_text_field.dart';

class AddTipScreen extends StatefulWidget {
  const AddTipScreen({
    this.tipModel,
    super.key,
  });

  final TipModel? tipModel;

  @override
  State<AddTipScreen> createState() => _AddTipScreenState();
}

class _AddTipScreenState extends State<AddTipScreen> {
  bool isVIP = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.tipModel != null) {
      titleController.text = widget.tipModel!.tipTitle;
      bodyController.text = widget.tipModel!.tipDescription;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;
    return Scaffold(
      appBar: MainAppBar(
        title: 'Add Tip',
        backIcon: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: AppColors.primaryDark,
          ),
        ),
        actions: widget.tipModel != null
            ? [
                DeleteWidget(onTap: () {}),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              AppTexts.body(
                text: 'Tip Title',
                fontSize: 15.sp,
                fontColor: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10.h,
              ),
              MainTextField(
                controller: titleController,
                hintText: 'Enter tip title',
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTexts.body(
                text: 'Tip Cover',
                fontSize: 15.sp,
                fontColor: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10.h,
              ),
              BlocConsumer<ImagePickerCubit, ImagePickerState>(
                listener: (context, state) {
                  if (state.imageStatus == ImageStatus.error) {
                    showErrorSnackBar(
                      context: context,
                      errorMessage: 'Please allow access to your photos',
                    );
                  }
                },
                builder: (context, state) {
                  return AddCoverWidget(
                    cover: widget.tipModel == null
                        ? state.imageFile.path
                        : widget.tipModel!.tipCover,
                    isNewCover: widget.tipModel != null,
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTexts.body(
                text: 'Tip Type',
                fontSize: 15.sp,
                fontColor: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10.h,
              ),
              TipTypeSelectionWidget(
                icon: 'assets/icons/24-hours.png',
                label: 'Daily Tip',
                onTap: widget.tipModel != null
                    ? null
                    : () {
                        setState(() {
                          isVIP = false;
                        });
                      },
                isSelected:
                    widget.tipModel != null ? !widget.tipModel!.isVIP : !isVIP,
              ),
              SizedBox(
                height: 10.h,
              ),
              TipTypeSelectionWidget(
                icon: 'assets/icons/premium.png',
                label: 'VIP Tip',
                onTap: widget.tipModel != null
                    ? null
                    : () {
                        setState(() {
                          isVIP = true;
                        });
                      },
                isSelected:
                    widget.tipModel != null ? widget.tipModel!.isVIP : isVIP,
              ),
              SizedBox(
                height: 20.h,
              ),
              AppTexts.body(
                text: 'Tip Body',
                fontSize: 15.sp,
                fontColor: AppColors.primaryDark,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: 10.h,
              ),
              MainTextField(
                controller: bodyController,
                hintText: 'Enter tip body',
                textInputAction: TextInputAction.newline,
                isMultiline: true,
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<TipsBloc, TipsState>(
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
                        if (widget.tipModel != null) {
                          final updatedTip = TipModel(
                            id: widget.tipModel!.tipId,
                            tipTitle: titleController.text,
                            tipCover: widget.tipModel!.tipCover,
                            tipDescription: bodyController.text,
                            isVIP: isVIP,
                            createdAt: widget.tipModel!.createdAt,
                          );
                          context.read<TipsBloc>().add(
                                UpdateTipEvent(
                                  updatedTip: updatedTip,
                                ),
                              );
                        } else {
                          context.read<TipsBloc>().add(
                                AddTipEvent(
                                  title: titleController.text,
                                  body: bodyController.text,
                                  isVIP: isVIP,
                                  coverFile: imageState.imageFile,
                                ),
                              );
                        }
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
