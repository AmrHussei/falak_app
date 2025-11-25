import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';

class ProfileCartWidget extends StatelessWidget {
  const ProfileCartWidget({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
    this.isRed = false,
  });

  final String text, image;
  final Function() onTap;
  final bool isRed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
          child: Row(
            children: [
              SizedBox(
                width: 32.w,
                height: 32.h,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      image,
                      fit: BoxFit.contain,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ],
                ),
              ),
              8.horizontalSpace,
              Text(
                text,
                style: AppStyles.styleRegular16(context).copyWith(
                  color: isRed
                      ? AppColors.error(context)
                      : AppColors.typographyHeading(context),
                ),
              ),
              Spacer(),
              if (!isRed)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFAFAFA) /* Surface-primary */,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFE1E1E2) /* Borders-primary */,
                      ),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  child: Transform.flip(
                    flipX: true,
                    child: SvgPicture.asset(
                      AppAssets.app_imagesArrow,
                      fit: BoxFit.contain,
                      height: 12.h,
                      width: 12.w,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
