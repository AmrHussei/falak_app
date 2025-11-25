import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';

/// Primary elevated button with gradient background
///
/// Usage:
/// ```dart
/// AppPrimaryButton(
///   onPressed: () {},
///   text: 'تسجيل الدخول',
///   isDisabled: false,
/// )
/// ```
class AppPrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isDisabled;
  final double? width;
  final double? height;
  final bool isLoading;
  final Widget? loadingWidget;

  const AppPrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isDisabled = false,
    this.width,
    this.height,
    this.isLoading = false,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 327.w,
      height: height ?? 48.h,
      decoration: BoxDecoration(
        gradient: isDisabled
            ? null
            : LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.buttonGradientStart(context),
                  AppColors.buttonGradientEnd(context),
                ],
              ),
        color: isDisabled ? AppColors.disabled(context) : null,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: isDisabled
            ? [
                BoxShadow(
                  color: const Color(0xFFC4C4C4),
                  offset: Offset(0, 0),
                  blurRadius: 0,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: const Color(0x260C2722),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: ElevatedButton(
        onPressed: isDisabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? (loadingWidget ??
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDisabled
                          ? AppColors.typographySubTitle(context)
                          : AppColors.white(context),
                    ),
                  ),
                ))
            : Text(
                text,
                style: AppStyles.styleMedium16(context).copyWith(
                  color: isDisabled
                      ? AppColors.typographySubTitle(context)
                      : AppColors.white(context),
                ),
              ),
      ),
    );
  }
}

/// Secondary button with solid background color
///
/// Usage:
/// ```dart
/// AppSecondaryButton(
///   onPressed: () {},
///   text: 'إلغاء',
///   icon: 'assets/icons/close.svg', // Optional
/// )
/// ```
class AppSecondaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String? icon;
  final double? width;
  final double? height;
  final bool isLoading;
  final Widget? loadingWidget;

  const AppSecondaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.width,
    this.height,
    this.isLoading = false,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 327.w,
      height: height ?? 48.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.backgroundTertiary(context),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? (loadingWidget ??
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.typographyHeading(context),
                    ),
                  ),
                ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    SvgPicture.asset(
                      icon!,
                      width: 20.w,
                      height: 20.h,
                    ),
                    8.horizontalSpace,
                  ],
                  Text(
                    text,
                    style: AppStyles.styleMedium14(context).copyWith(
                      color: AppColors.typographyHeading(context),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Outlined button with border
///
/// Usage:
/// ```dart
/// AppOutlinedButton(
///   onPressed: () {},
///   text: 'تسجيل الدخول عبر نفاذ',
///   icon: 'assets/icons/nafath.svg', // Optional
/// )
/// ```
class AppOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final String? icon;
  final double? width;
  final double? height;
  final bool isLoading;
  final Widget? loadingWidget;

  const AppOutlinedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.width,
    this.height,
    this.isLoading = false,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 327.w,
      height: height ?? 48.h,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: AppColors.borderPrimary(context),
            width: 1.w,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? (loadingWidget ??
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.secondColor(context),
                    ),
                  ),
                ))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    SvgPicture.asset(
                      icon!,
                      width: 20.w,
                      height: 20.h,
                    ),
                    8.horizontalSpace,
                  ],
                  Text(
                    text,
                    style: AppStyles.styleSemiBold14(context).copyWith(
                      color: AppColors.secondColor(context),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

