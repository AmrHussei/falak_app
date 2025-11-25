import 'dart:io';

import 'package:falak/core/widgets/coustom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/profile/presentation/view/widgets/change_date_sheet.dart';

import '../../../../../app/app.dart';
import '../../../../../app/injector.dart';
import '../../../../../core/functions/local_auth.dart';
import '../../../../../core/storage/i_app_local_storage.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/guest_widget.dart';
import '../../../../../core/widgets/my_snackbar.dart';
import '../widgets/profile/profile_cart_widget.dart';
import '../widgets/profile/show_log_out_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    _updateStatusBar();
    super.initState();
  }

  void _updateStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: AppColors.white(context),
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.white(context),
      ),
    );
    Future.delayed(Duration(milliseconds: 100)).then((v) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateStatusBar();
    bool isAppLocked =
        serviceLocator<IAppLocalStorage>().getValue(AppStrings.isAppLocked) ??
        false;
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
