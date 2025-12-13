import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../view_model/profile/profile_cubit.dart';

class AgenciesScreen extends StatelessWidget {
  const AgenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary(context),
      appBar: CoustomAppBarWidget(title: 'الوكالات'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            AgenciesCardWidegt(
              onTap: () {
                context.read<ProfileCubit>().status = AppStrings.approved;
                context.navigateTo(Routes.AgenciesDetailsScreen, 'النشطة');
              },
              boxColor: const Color(0x0C1D6E4F),
              icon: AppAssets.app_imagesActiveSvg,
              title: 'النشطة',
            ),
            16.verticalSpace,
            AgenciesCardWidegt(
              onTap: () {
                context.read<ProfileCubit>().status = AppStrings.pending;
                context.navigateTo(Routes.AgenciesDetailsScreen, 'تحت الإجراء');
              },
              boxColor: const Color(0x0C9E5C21),
              icon: AppAssets.app_imagesPindding,
              title: 'تحت الإجراء',
            ),
            16.verticalSpace,
            AgenciesCardWidegt(
              onTap: () {
                context.read<ProfileCubit>().status = AppStrings.blocked;
                context.navigateTo(Routes.AgenciesDetailsScreen, 'الملغية');
              },
              boxColor: const Color(0x0C2E343F),
              icon: AppAssets.app_imagesCanceled,
              title: 'الملغية',
            ),
            16.verticalSpace,
            AgenciesCardWidegt(
              onTap: () {
                context.read<ProfileCubit>().status = AppStrings.rejected;
                context.navigateTo(Routes.AgenciesDetailsScreen, 'المرفوضة');
              },
              boxColor: const Color(0x0CAF2A1A),
              icon: AppAssets.app_imagesRejected,
              title: 'المرفوضة',
            ),
            16.verticalSpace,
            AgenciesCardWidegt(
              onTap: () {
                context.read<ProfileCubit>().status = AppStrings.terminated;
                context.navigateTo(Routes.AgenciesDetailsScreen, 'المنتهية');
              },
              boxColor: const Color(0x0CAF2A1A),
              icon: AppAssets.app_imagesTerminated,
              title: 'المنتهية',
            ),
          ],
        ),
      ),
    );
  }
}

class AgenciesCardWidegt extends StatelessWidget {
  const AgenciesCardWidegt({
    super.key,
    required this.title,
    required this.icon,
    required this.boxColor,
    required this.onTap,
  });

  final String title, icon;
  final Color boxColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.zero,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: 8.w,
              end: 16.w,
              top: 8.h,
              bottom: 8.h,
            ),
            child: Row(
              children: [
                SvgPicture.asset(icon, height: 38.h, width: 38.w),
                12.horizontalSpace,
                Text(
                  title,
                  style: AppStyles.styleRegular18(
                    context,
                  ).copyWith(color: AppColors.titleColor(context)),
                ),
                Spacer(),
                PopWidget(
                  height: 14.h,
                  width: 14.w,
                  padding: 6,
                  radius: 6,
                  flip: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
