import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hknance/widgets/tips_screen_related_widgets/tip_categories_list_widget.dart';


import '../../view_controllers/tip_categories_cubit/tip_categories_cubit.dart';
import '../main_app_button.dart';
import 'add_tip_category_dialog.dart';

class TipCategoriesWidget extends StatelessWidget {
  const TipCategoriesWidget({
    super.key,
    required this.tpSlController,
  });

  final TextEditingController tpSlController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TipCategoriesListWidget(),
        MainAppButton(
          label: 'اضف تصنيف النصيحة',
          height: 45.h,
          width: double.maxFinite,
          onTap: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => BlocProvider.value(
                value: context.read<TipCategoriesCubit>(),
                child:
                AddTipCategoryDialog(tpSlController: tpSlController),
              ),
            );
          },
          borderRadius: 12.r,
        ),
      ],
    );
  }
}



