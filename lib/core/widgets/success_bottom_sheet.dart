import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/global_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessBottomSheet extends StatelessWidget {
  const SuccessBottomSheet({
    super.key,
    this.title,
    this.action,
    this.subText,
    this.subSubText,
    this.haveButton = true,
    this.haveImage = true,
    this.height,
    this.image,
  });

  final String? title;
  final Function? action;
  final String? subText;
  final String? subSubText;
  final bool haveButton;
  final bool haveImage;
  final double? height;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return GlobalBottomSheet(
      height: height ?? 387.h,
      title: title ?? 'تغير كلمة المرور',
      action: () {
        if (action != null) {
          action?.call();
        } else {
          context.pop();
          context.pop();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (haveImage) ...[
            SvgPicture.asset(
              image ?? AppAssets.imagesLock,
              height: 125.h,
              width: 181.w,
            ),
            12.verticalSpace,
          ],
          Text(
            subText ?? 'تم تغير كلمة المرور بنجاح',
            style: AppStyles.styleBold18(context),
          ),
          if (subSubText != null) ...[
            8.verticalSpace,
            Text(
              subSubText!,
              textAlign: TextAlign.center,
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: AppColors.grayText(context)),
            ),
          ],
          if (haveButton) ...[
           16.verticalSpace,
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
        ],
      ),
    );
  }
}
