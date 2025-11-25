import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/utils/app_colors.dart';

class StepsWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final double? height;
  final double? width;
  final double? spacing;

  const StepsWidget({
    Key? key,
    required this.currentStep,
    this.totalSteps = 3,
    this.height,
    this.width,
    this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index <= currentStep;

        return AnimatedContainer(
          margin: EdgeInsets.symmetric(horizontal: 3.w),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          height: height ?? 3.h,
          width: width ?? 29.5.w,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary(context)
                : AppColors.disabled(context),
            borderRadius: BorderRadius.circular(100.r),
          ),
        );
      }),
    );
  }
}
