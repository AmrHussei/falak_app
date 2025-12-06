import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WinnerWidget extends StatelessWidget {
  const WinnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 303.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0x1A0E4C2B),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.imagesWinner, height: 20.h, width: 20.w),
          Text(
            'مبروك انت الرابح',
            style: AppStyles.styleBold16(
              context,
            ).copyWith(color: const Color(0xff009951)),
          ),
        ],
      ),
    );
  }
}
