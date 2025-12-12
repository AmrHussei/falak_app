import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/app/app.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/home/presentation/view/widgets/assets_details/enrollment_buttom_sheet.dart';
import 'package:falak/features/home/presentation/view/widgets/mozayda_sheet/auction_price_and_add_widegts.dart';
import 'package:falak/features/home/presentation/view/widgets/mozayda_sheet/enrollment_first_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/mozayda_sheet/mozayda_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../generated/assets.dart';
import '../../../view_model/home/home_cubit.dart';

class MozaydaBoardWidget extends StatelessWidget {
  const MozaydaBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Column(
      children: [
        Container(
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
              TopMozaydaWidget(),
              8.verticalSpace,
              AuctionPriceWidegt(),
            ],
          ),
        ),
        16.verticalSpace,

        KisGuest
            ? enrollmentFirstWidget(height: 80.h)
            : homeCubit.auctionOrigin!.isEnrolled == false
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RowWidget(
                    title: 'عربون الدخول',
                    subTitle: formatNumber(
                      homeCubit.auctionOrigin!.entryDeposit,
                    ),
                    icon: Assets.appImagesBillCheck,
                    subIcon: Assets.imagesRiyal,
                    titleStyle: AppStyles.styleMedium16(
                      context,
                    ).copyWith(color: AppColors.typographyHeading(context)),
                    subTitleStyle: AppStyles.styleBold18(
                      context,
                    ).copyWith(color: AppColors.typographyHeading(context)),
                  ),
                  16.verticalSpace,
                  EnrollmentWalletWidget(),
                  32.verticalSpace,
                  AppPrimaryButton(
                    width: double.infinity,
                    onPressed: () {
                      context.read<HomeCubit>().type =
                          AppStrings.enrolltypeOnline;
                      enrollmentSheetBottomSheet(context);
                    },
                    text: 'حجز عربون الدخول',
                  ),
                ],
              )
            : AddMozaydaWidget(),
      ],
    );
  }
}
