import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hknance/data_models/new_data_model.dart';
import 'package:hknance/utils/confirm_dialoge.dart';
import 'package:hknance/utils/errors/error_snack_bar.dart';
import 'package:hknance/utils/theme/app_colors.dart';
import 'package:hknance/utils/theme/app_texts.dart';
import 'package:hknance/view_controllers/image_picker_cubit/image_picker_cubit.dart';
import 'package:hknance/view_controllers/news_bloc/news_bloc.dart';
import 'package:hknance/view_controllers/sign_up_cubit/sign_up_cubit.dart';
import 'package:hknance/widgets/admin_related_widgets/add_cover_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/delete_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/save_button.dart';
import 'package:hknance/widgets/main_app_bar.dart';
import 'package:hknance/widgets/main_loading.dart';
import 'package:hknance/widgets/main_text_field.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({
    this.newModel,
    required this.isAnalysis,
    super.key,
  });

  final NewModel? newModel;
  final bool isAnalysis;

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.newModel != null) {
      titleController.text = widget.newModel!.newTitle;
      bodyController.text = widget.newModel!.newDescription;
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<NewsBloc, NewsState>(
            listener: (context, state) async {
              if (state.loadingStatus == LoadingStatus.loaded) {
                Navigator.pop(context);
              } else if (state.loadingStatus == LoadingStatus.error) {
                showErrorSnackBar(
                  context: context,
                  errorMessage: state.errorHandler.message,
                );
              }
            },
          ),
          BlocListener<ImagePickerCubit, ImagePickerState>(
            listener: (context, state) {
              if (state.imageStatus == ImageStatus.error) {
                showErrorSnackBar(
                  context: context,
                  errorMessage: 'Please allow access to your photos',
                );
              }
            },
          ),
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: MainAppBar(
            title: widget.isAnalysis ? 'add_analysis'.tr : 'add_news'.tr,
            backIcon: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
                color: AppColors.primaryDark,
              ),
            ),
            actions: widget.newModel != null
                ? [
                    DeleteWidget(
                      onTap: () async {
                        showConfirmDialog(
                          context: context,
                          onDelete: () async {
                            context.read<NewsBloc>().add(
                                  DeleteNewEvent(
                                    newId: widget.newModel!.newId,
                                  ),
                                );
                            Navigator.of(context).pop();
                          },
                          title: 'delete_news'.tr,
                        );
                      },
                    ),
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
                    text: widget.isAnalysis ? 'analysis_title'.tr : 'new_title'.tr,
                    fontSize: 15.sp,
                    fontColor: AppColors.primaryDark,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MainTextField(
                    controller: titleController,
                    hintText: widget.newModel == null
                        ? widget.isAnalysis ? 'analysis_title_field'.tr : 'new_title_field'.tr
                        : widget.newModel!.newTitle,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppTexts.body(
                    text: widget.isAnalysis ? 'analysis_cover'.tr : 'new_cover'.tr,
                    fontSize: 15.sp,
                    fontColor: AppColors.primaryDark,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocBuilder<ImagePickerCubit, ImagePickerState>(
                    builder: (context, state) {
                      return AddCoverWidget(
                        cover: widget.newModel == null
                            ? state.imageFile.path
                            : widget.newModel!.newCover,
                        isNewCover: widget.newModel != null,
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  AppTexts.body(
                    text: widget.isAnalysis ? 'analysis_desc'.tr : 'new_desc'.tr,
                    fontSize: 15.sp,
                    fontColor: AppColors.primaryDark,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  MainTextField(
                    controller: bodyController,
                    hintText: widget.newModel == null
                        ? widget.isAnalysis ? 'analysis_desc_field'.tr : 'new_desc_field'.tr
                        : widget.newModel!.newDescription,
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
          bottomNavigationBar: BlocBuilder<ImagePickerCubit, ImagePickerState>(
            builder: (context, state) {
              return context.watch<NewsBloc>().state.loadingStatus ==
                      LoadingStatus.loading
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: 28.w,
                        right: 28.w,
                        bottom: bottomPadding == 0 ? 20.h : bottomPadding.h,
                      ),
                      child: const MainLoading(),
                    )
                  : SaveButton(
                      onTap: () async {
                        updateOrAddNew(
                          context: context,
                          title: titleController.text,
                          body: bodyController.text,
                          imageFile: state.imageFile,
                          updatedNew: widget.newModel,
                          isAnalysis: widget.isAnalysis
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}

void updateOrAddNew({
  required BuildContext context,
  NewModel? updatedNew,
  required String title,
  required String body,
  required File imageFile,
  required bool isAnalysis,
}) {
  if (updatedNew != null) {
    if (title.isNotEmpty && body.isNotEmpty) {
      final NewModel newModel = NewModel(
        id: updatedNew.newId,
        newTitle: title,
        newCover: '',
        isAnalysis:isAnalysis,
        newDescription: body,
        createdAt: DateTime.now(),
      );
      context.read<NewsBloc>().add(
            UpdateNewEvent(
              newModel: newModel,
            ),
          );
    } else {
      showErrorSnackBar(
        context: context,
        errorMessage: 'fill_fields'.tr,
      );
    }
  } else {
    if (title.isNotEmpty && body.isNotEmpty && imageFile.path.isNotEmpty) {
      final NewModel newModel = NewModel(
        newTitle: title,
        newCover: '',
        isAnalysis: isAnalysis,
        newDescription: body,
        createdAt: DateTime.now(),
      );
      context.read<NewsBloc>().add(
            AddNewEvent(
              newModel: newModel,
              newCover: imageFile,
              isAnalysis: isAnalysis,
            ),
          );
    } else {
      showErrorSnackBar(
        context: context,
        errorMessage: 'fill_fields'.tr,
      );
    }
  }
}
