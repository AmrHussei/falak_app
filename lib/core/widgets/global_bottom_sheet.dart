import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlobalBottomSheet extends StatelessWidget {
  const GlobalBottomSheet({
    super.key,
    required this.title,
    this.action,
    this.height,
    required this.child,
    this.color,
    this.padding,
  });

  final String title;
  final GestureTapCallback? action;
  final double? height;
  final Widget child;
  final Color? color;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: padding??15.5.w,
        left: padding??15.5.w,
        bottom: context.bottomPadding + 8.h,
      ),
      child: Container(
        height: height ?? 387.h,
        width: 359.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          color: color ?? Colors.white,
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
                Text(title, style: AppStyles.styleBold18(context)),
                InkWell(
                  onTap: action,
                  child: SvgPicture.asset(
                    AppAssets.app_imagesCloseSquare,
                    height: 24.h,
                  ),
                ),
              ],
            ),
            32.verticalSpace,
            child,
          ],
        ),
      ),
    );
  }
}
