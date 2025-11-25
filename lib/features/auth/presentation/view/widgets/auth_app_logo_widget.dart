import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_images.dart';

import '../../../../../core/utils/images.dart';

class AuthAppLogoWidget extends StatelessWidget {
  const AuthAppLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.app_imagesAppLogo,
      fit: BoxFit.contain,
      width: 105.w,
      height: 56.87.h,
    );
  }
}

class CurrancyLogoWidget extends StatelessWidget {
  const CurrancyLogoWidget({
    super.key,
    this.color,
    this.maxHeight,
    this.maxWidth,
  });
  final Color? color;
  final double? maxHeight, maxWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? 24,
        maxWidth: maxWidth ?? 24,
      ),
      child: SvgPicture.asset(
        Assets.imagesCurrencyIcon,
        fit: BoxFit.contain,
        color: color ?? AppColors.typographyHeading(context),
      ),
    );
  }
}
