
import 'package:falak/core/widgets/coustom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';

import '../../../../../app/app.dart';
import '../../../../../core/widgets/guest_widget.dart';
import '../widgets/profile/profile_cart_widget.dart';
import '../widgets/profile/show_log_out_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CoustomAppBarWidget(
        leading: const SizedBox.shrink(),
        title: 'حسابي',
      ),
      body: KisGuest == true
          ? GuestWidget()
          : SingleChildScrollView(
              padding:  EdgeInsets.symmetric(horizontal: 23.5.w,vertical: 16.h),
              child: Column(
                children: [
                  ProfileCartWidget(
                    image: AppAssets.app_imagesProfilr,
                    onTap: () {
                      context.navigateTo(Routes.userInfoScreen);
                    },
                    text: 'المعلومات الشخصية',
                  ),
                  8.verticalSpace,
                  ProfileCartWidget(
                    image: AppAssets.app_imagesHeart,
                    onTap: () {
                      context.navigateTo(Routes.savedMazadeScreen);
                    },
                    text: 'المفضلة',
                  ),
                  8.verticalSpace,

                  ProfileCartWidget(
                    image: AppAssets.app_imagesAgencies,
                    onTap: () {
                      context.navigateTo(Routes.agenciesScreen);
                    },
                    text: 'الوكالات',
                  ),
                  8.verticalSpace,
                  ProfileCartWidget(
                    image: AppAssets.app_imagesChangePassword,
                    onTap: () {
                      context.navigateTo(Routes.changePasswordScreen);
                    },
                    text: 'تغير كلمة المرور',
                  ),
                  8.verticalSpace,

                  ProfileCartWidget(
                    image: AppAssets.app_imagesProfileArrow,
                    onTap: () {
                      showLogOutBottomSheet(context);
                    },
                    text: 'تسجيل الخروج',
                    isRed: true,
                  ),
                ],
              ),
            ),
    );
  }
}
