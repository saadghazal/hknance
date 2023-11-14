import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteWidget extends StatelessWidget {
  const DeleteWidget({required this.onTap,super.key});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 5.h, right: 16.w,left: 16.w),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: const Center(
            child: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}
