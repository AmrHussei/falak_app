import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.subIcon,
  });

  final String title;
  final String subTitle;
  final String icon;
  final String? subIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(icon, height: 20.h, width: 20.w),
            8.horizontalSpace,
            Text(
              title,
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: AppColors.inputsPlaceholder(context)),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              subTitle,
              style: AppStyles.styleMedium14(
                context,
              ).copyWith(color: AppColors.typographyHeading(context)),
            ),
            if (subIcon != null) ...[
              4.horizontalSpace,
              SvgPicture.asset(
                subIcon!,
                color: AppColors.black(context),
                height: 15.h,
                width: 15.w,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
