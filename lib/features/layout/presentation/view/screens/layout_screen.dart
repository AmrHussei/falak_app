import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/app/app.dart';
import 'package:falak/core/utils/images.dart';

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
      drawer: DrawerWidget(toggleDrawer: toggleDrawer,),
      bottomNavigationBar: Container(
        height: 84,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.inputBorder(context),
              width: 1.h,
            ),
          ),
        ),
        child: BottomAppBar(
          color: Colors.white,
          shadowColor: AppColors.backgroundGrey(context),
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(
                context,
                iconPath: AppAssets.app_imagesHome2,
                label: 'الرئيسية',
                index: 0,
              ),
              _buildNavItem(
                context,
                iconPath: AppAssets.app_imagesGavelLawBlackIcon,
                label: 'مزاداتي',
                index: 1,
              ),
              _buildNavItem(
                context,
                iconPath: AppAssets.app_imagesWallet,
                label: 'محفظتي',
                index: 2,
              ),
              _buildNavItem(
                context,
                iconPath: AppAssets.app_imagesFrame,
                label: 'الملف الشخصي',
                index: 3,
              ),
            ],
          ),
        ),
      ),
      body: AppRoutes
          .layoutScreenBody[KcurrentIndex], // Switch body dynamically
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String iconPath,
    required String label,
    required int index,
  }) {
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          KcurrentIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: SvgPicture.asset(
              iconPath,
              color: KcurrentIndex == index
                  ? AppColors.primary(context) // Selected color
                  : AppColors.typographyHeading(context), // Unselected color
            ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: AppStyles.styleRegular14(context).copyWith(
              color: KcurrentIndex == index
                  ? AppColors.primary(context) // Selected color
                  : AppColors.typographyHeading(context), // Unselected color
            ),
          ),
          SizedBox(height: 4),
          KcurrentIndex == index
              ? SvgPicture.asset(AppAssets.app_imagesUnion)
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
