import 'package:falak/core/utils/app_strings.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/features/home/presentation/view/widgets/assets_details/logout_auction_sheet.dart';
import 'package:falak/features/home/presentation/view/widgets/assets_details/register_auction_sheet.dart';
import 'package:falak/features/home/presentation/view/widgets/mozayda_sheet/mozayda_sheet.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../view_model/home/home_cubit.dart';

class CurrentAndCommingActionForAssetsWidget extends StatelessWidget {
  const CurrentAndCommingActionForAssetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    final model = homeCubit.auctionData!;
    final origin = homeCubit.auctionOrigin!;
    return Column(
      children: [
        if (model.status == AppStrings.auctionsInProgress)
          BlocBuilder<HomeCubit, HomeState>(
            builder: (_, _) {
              return Column(
                children: [
                  AppPrimaryButton(
                    color: origin.isEnrolled! ? Color(0xff008043) : null,
                    onPressed: () {
                      context.read<HomeCubit>().auctionOrigin = origin;
                      KoriginId = origin.id;
                      if (origin.isEnrolled!) {
                        return;
                      } else {
                        registerAuctionSheet(context);
                      }
                    },
                    text: origin.isEnrolled!
                        ? 'أنت مسجل في المزاد'
                        : 'سجل في المزاد',
                    icon: origin.isEnrolled!
                        ? AppAssets.app_imagesEnrolledMazadtrue
                        : null,
                  ),
                  if (origin.isEnrolled!) ...[
                    16.verticalSpace,
                    AppPrimaryButton(
                      color: Color(0xffBD2915),
                      onPressed: () {
                        LogOutFromAuctionSheetBottomSheet(context);
                      },
                      text: 'الخروج من المزاد',
                      icon: AppAssets.app_imagesLogoutFromAuction,
                    ),
                  ],
                ],
              );
            },
          ),
        if (model.status == AppStrings.auctionsOnGoing)
          AppPrimaryButton(
            onPressed: () {
              context.read<HomeCubit>().addNewBidValue();

              mozaydaSheetBottomSheet(context);
            },
            text: 'لوحة المزاد',
            icon: Assets.appImagesEnrolledMazadtrue,
          ),
      ],
    );
  }
}
