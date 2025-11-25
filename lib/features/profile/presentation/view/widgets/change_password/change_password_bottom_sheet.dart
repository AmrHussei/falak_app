import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangePasswordBottomSheet extends StatelessWidget {
  const ChangePasswordBottomSheet({
    super.key,
    this.title,
    this.action,
    this.subText,
  });

  final String? title;
  final Function? action;
  final String? subText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 15.5.w,
        left: 15.5.w,
        bottom: context.bottomPadding + 8.h,
      ),
      child: Container(
        height: 387.h,
        width: 359.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            Container(
              height: 4.h,
              width: 40.w,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Color(0xffD0D2D2),
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title ?? 'تغير كلمة المرور',
                  style: AppStyles.styleBold18(context),
                ),
                InkWell(
                  onTap: () {
                    if (action != null) {
                      action!();
                    } else {
                      context.pop();
                      context.pop();
                    }
                  },
                  child: SvgPicture.asset(
                    AppAssets.app_imagesCloseSquare,
                    height: 24.h,
                  ),
                ),
              ],
            ),
            32.verticalSpace,
            SvgPicture.asset(AppAssets.imagesLock, height: 125.h, width: 181.w),
            12.verticalSpace,
            Text(
              subText ?? 'تم تغير كلمة المرور بنجاح',
              style: AppStyles.styleBold18(context),
            ),
            const Spacer(),
            AppPrimaryButton(
              onPressed: () {
                if (action != null) {
                  action!();
                } else {
                  context.pop();
                  context.pop();
                }
              },
              text: 'الرئيسية',
            ),
          ],
        ),
      ),
    );
  }
}
