import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/app/app.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../home/presentation/view/screens/home_screen.dart';
import '../../../../home/presentation/view/widgets/home/drawer_widget.dart';
import '../../../../profile/presentation/view_model/profile/profile_cubit.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

int KcurrentIndex = 0;

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    super.initState();
    if (!KisGuest) {
      context.read<ProfileCubit>().getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      drawer: DrawerWidget(toggleDrawer: toggleDrawer),
      bottomNavigationBar: Container(
        height: 84,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.inputBorder(context), width: 1.h),
          ),
        ),
        child: Card(
          color: Colors.white,
          shadowColor: AppColors.backgroundGrey(context),
          margin: EdgeInsets.zero,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem(
                context,
                iconPath: Assets.imagesHome,
                activeIconPath: Assets.imagesHomeActive,
                label: 'الرئيسية',
                index: 0,
              ),
              _buildNavItem(
                context,
                iconPath: Assets.imagesMazad,
                activeIconPath: Assets.imagesMazadActive,
                label: 'مزاداتي',
                index: 1,
              ),
              _buildNavItem(
                context,
                iconPath: Assets.imagesWallet,
                activeIconPath: Assets.imagesWalletActive,
                label: 'المحفظة',
                index: 2,
              ),
              _buildNavItem(
                context,
                iconPath: Assets.imagesProfile,
                activeIconPath: Assets.imagesProfileActive,
                label: 'حسابي',
                index: 3,
              ),
            ],
          ),
        ),
      ),
      body:
          AppRoutes.layoutScreenBody[KcurrentIndex], // Switch body dynamically
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String iconPath,
    required String activeIconPath,
    required String label,
    required int index,
  }) {
    return Expanded(
      child: InkWell(
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          setState(() {
            KcurrentIndex = index;
          });
        },
        child: SizedBox(
          height: 78.h,
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              if (KcurrentIndex == index)
                SizedBox(
                  width: 69.w,
                  child: Column(
                    children: [
                      Container(
                        width: 69.w,
                        height: 1.h,
                        decoration: BoxDecoration(
                          color: AppColors.buttonGradientEnd(context),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.backgroundPrimary(
                                  context,
                                ).withValues(alpha: 0.0),
                                AppColors.buttonGradientEnd(
                                  context,
                                ).withValues(alpha: 0.1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    KcurrentIndex == index ? activeIconPath : iconPath,
                    height: 24.h,
                    width: 24.w,
                  ),
                  4.verticalSpace,
                  Text(
                    label,
                    style: AppStyles.styleRegular13(context).copyWith(
                      color: KcurrentIndex == index
                          ? AppColors.primary(context) // Selected color
                          : AppColors.typographyHeading(
                              context,
                            ), // Unselected color
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
