import 'package:falak/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';

class enrollmentFirstWidget extends StatelessWidget {
  const enrollmentFirstWidget({super.key, this.padding});

  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100.h,
          alignment: AlignmentGeometry.center,
          decoration: ShapeDecoration(
            color: const Color(0x0C226C43),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.app_imagesPerson,
                height: 44.h,
                width: 44.w,
              ),
              12.verticalSpace,
              Text(
                'أنت غير مسجل بالمنصة.. يرجى تسجيل الدخول أولا',
                textAlign: TextAlign.start,
                style: AppStyles.styleRegular14(
                  context,
                ).copyWith(color: AppColors.typographyHeading(context)),
              ),
            ],
          ),
        ),
        32.verticalSpace,
        AppPrimaryButton(
          onPressed: () {
            context.navigateTo(Routes.login);
          },
          text:  'تسجيل الدخول',
        ),
      ],
    );
  }
}
