import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestDrawerWidget extends StatelessWidget {
  const GuestDrawerWidget({super.key, required this.toggleDrawer});

  final Function() toggleDrawer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مرحباً بك في فلك الخير 👋',
            style: AppStyles.styleBold16(context),
          ),
          6.verticalSpace,
          Text(
            'سجل دخول أو أنشئ حساب للوصول لكل المميزات.',
            style: AppStyles.styleRegular12(context),
          ),
          8.verticalSpace,
          SizedBox(
            height: 32.h,
            child: Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    radius: 8.r,
                    onPressed: () {
                      toggleDrawer();
                      context.navigateTo(Routes.login);
                    },
                    text: 'تسجيل الدخول',
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: AppPrimaryButton(
                    radius: 8.r,
                    onPressed: () {
                      toggleDrawer();

                      context.navigateTo(Routes.signUpScreen);
                    },
                    text: 'إنشاء حساب',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
