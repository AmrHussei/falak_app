import 'package:falak/core/utils/app_strings.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/features/home/presentation/view/widgets/assets_details/current_and_comming_action_for_assets_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/asset_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/functions/time_zon_fun.dart';
import '../../../../../../generated/assets.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/mazad_status_timer_widget.dart';

class AsseteDetailesCardWidget extends StatelessWidget {
  const AsseteDetailesCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    final model = homeCubit.auctionData!;
    final origin = homeCubit.auctionOrigin!;
    final titleStyle = AppStyles.styleRegular16(
      context,
    ).copyWith(color: AppColors.inputsPlaceholder(context));
    final subTitleStyle = AppStyles.styleMedium16(
      context,
    ).copyWith(color: AppColors.typographyHeading(context));
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.containerGrayColor(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 0.5,
            blurRadius: 1.5,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
          // if (model.status != AppStrings.auctionsInProgress) ...[
          //   Container(
          //     width: double.infinity,
          //     height: 56.h,
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //         end: Alignment.bottomCenter,
          //         colors: [
          //           AppColors.buttonGradientStart(context),
          //           AppColors.buttonGradientEnd(context),
          //         ],
          //       ),
          //       borderRadius: BorderRadius.circular(8.r),
          //     ),
          //     padding: EdgeInsets.symmetric(horizontal: 16.w),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Row(
          //           children: [
          //             SvgPicture.asset(
          //               Assets.imagesArrowUp1,
          //               height: 20.h,
          //               width: 20.w,
          //             ),
          //             8.horizontalSpace,
          //             Text(
          //               'أعلى مزايدة',
          //               style: AppStyles.styleMedium16(
          //                 context,
          //               ).copyWith(color: AppColors.white(context)),
          //             ),
          //           ],
          //         ),
          //         Row(
          //           children: [
          //             Text(
          //               formatNumber(origin.highestBid ?? 0),
          //               style: AppStyles.styleBold16(
          //                 context,
          //               ).copyWith(color: AppColors.white(context)),
          //             ),
          //             4.horizontalSpace,
          //             SvgPicture.asset(
          //               Assets.imagesRiyal,
          //               height: 15.h,
          //               width: 15.w,
          //               color: AppColors.white(context),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          //   16.verticalSpace,
          // ],

          RowWidget(
            title: 'تاريخ بداية المزاد',
            subTitle: formatDateFunction(model.startDate.toString()),
            icon: Assets.appImagesCalendar1,
            titleStyle: titleStyle,
            subTitleStyle: subTitleStyle,
          ),
          12.verticalSpace,
          RowWidget(
            title: 'وقت بداية المزاد',
            subTitle: formatTimeFunction(model.startDate.toString()),
            icon: Assets.appImagesAlarm,
            titleStyle: titleStyle,
            subTitleStyle: subTitleStyle,
          ),
          12.verticalSpace,
          RowWidget(
            title: 'السعر الافتتاحي',
            subTitle: formatNumber(origin.openingPrice),
            icon: Assets.appImagesBanknote,
            subIcon: Assets.imagesRiyal,
            titleStyle: titleStyle,
            subTitleStyle: subTitleStyle,
          ),
          12.verticalSpace,
          RowWidget(
            title: 'عربون الدخول',
            subTitle: formatNumber(origin.entryDeposit),
            icon: Assets.appImagesBillCheck,
            subIcon: Assets.imagesRiyal,
            titleStyle: titleStyle,
            subTitleStyle: subTitleStyle,
          ),
          12.verticalSpace,
          RowWidget(
            title: 'مدة المزاد',
            subTitle: '${model.numberOfDays ?? 0}  أيام',
            icon: Assets.appImagesClock,
            titleStyle: titleStyle,
            subTitleStyle: subTitleStyle,
          ),
          8.verticalSpace,
          Divider(),
          8.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(Assets.appImagesHourglassLine),
              8.horizontalSpace,
              Text(
                'تاريخ ويوم نهاية المزاد :',
                style: AppStyles.styleRegular16(
                  context,
                ).copyWith(color: AppColors.inputsPlaceholder(context)),
              ),
              4.horizontalSpace,
              Text(
                '${getDayNameArabic(model.startDate.toString())}' +
                    ' ' +
                    formatDateFunction(model.endDate.toString()),
                style: AppStyles.styleMedium16(
                  context,
                ).copyWith(color: AppColors.typographyHeading(context)),
              ),
            ],
          ),
          16.verticalSpace,
          homeCubit.auctionData?.status == AppStrings.auctionsCompleted
              ? CompletedAuctionStutesWidget()
              : CurrentAndCommingActionForAssetsWidget(),
        ],
      ),
    );
  }
}
