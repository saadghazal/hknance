import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/data_models/new_data_model.dart';
import 'package:hknance/utils/theme/app_colors.dart';
import 'package:hknance/utils/theme/app_texts.dart';
import 'package:hknance/view_controllers/image_picker_cubit/image_picker_cubit.dart';
import 'package:hknance/view_controllers/news_bloc/news_bloc.dart';
import 'package:hknance/widgets/admin_related_widgets/add_cover_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/delete_widget.dart';
import 'package:hknance/widgets/admin_related_widgets/save_button.dart';
import 'package:hknance/widgets/main_app_bar.dart';
import 'package:hknance/widgets/main_text_field.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({
    this.newModel,
    super.key,
  });

  final NewModel? newModel;

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    bodyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: MainAppBar(
          title: 'Add New',
          backIcon: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.close,
              color: AppColors.primaryDark,
            ),
          ),
          actions:
              widget.newModel != null ? [DeleteWidget(onTap: () {})] : null,
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
                  text: 'New Title',
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
                      ? 'Enter the new title'
                      : widget.newModel!.newTitle,
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: 'New Cover',
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
                      tipCover: widget.newModel == null
                          ? state.imageFile.path
                          : widget.newModel!.newCover,
                    );
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                AppTexts.body(
                  text: 'New Body',
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
                      ? 'Enter the new content'
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
            return SaveButton(onTap: () async {
              if (titleController.text.isNotEmpty &&
                  titleController.text.isNotEmpty &&
                  state.imageFile.path.isNotEmpty) {
                final NewModel newModel = NewModel(
                  newTitle: titleController.text,
                  newCover: '',
                  newDescription: bodyController.text,
                );
                context.read<NewsBloc>().add(
                      AddNewEvent(
                        newModel: newModel,
                        newCover: state.imageFile,
                      ),
                    );
              }
            });
          },
        ),
      ),
    );
  }
}
