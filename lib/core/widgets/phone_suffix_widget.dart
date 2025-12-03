import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneSuffixWidget extends StatelessWidget {
  const PhoneSuffixWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40.h,
      width: 59.w,
      margin: EdgeInsetsDirectional.only(end: 6.w, start: 1.w),
      decoration: BoxDecoration(
        color: AppColors.containerGrayColor(context),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: Text(
        '966+',
        style: AppStyles.styleBold14(
          context,
        ).copyWith(color: AppColors.veryGrayColor(context)),
      ),
    );
  }
}
