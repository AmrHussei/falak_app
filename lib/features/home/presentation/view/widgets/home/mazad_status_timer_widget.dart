import 'dart:ui';

import 'package:falak/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_images.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/home/presentation/view/widgets/home/timer_home_widget.dart';

import '../../../../../../core/utils/images.dart';
import '../../../../data/models/auctions_model/auctions_model.dart';

class MazadStatusTimerWidget extends StatelessWidget {
  const MazadStatusTimerWidget({super.key, required this.auctionData});

  final AuctionData auctionData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimerContainerWidget(auctionData: auctionData),
        16.verticalSpace,
        Row(
          children: [
            Expanded(
              child: RowAssetsNumberCardWidget(
                text: 'الاصول ${auctionData.auctionOrigins.length}',
                image: AppAssets.app_imagesBriefcase,
              ),
            ),
            Expanded(
              child: RowAssetsNumberCardWidget(
                text: 'مدة المزاد ${auctionData.numberOfDays.toString()} ايام',
                image: AppAssets.app_imagesClock,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CompletedAuctionStutesWidget extends StatelessWidget {
  const CompletedAuctionStutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFFFCE8E8),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: AppColors.error(context)),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        'مزاد منتهي',
        style: AppStyles.styleBold16(context).copyWith(
          color: AppColors.error(context),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class RowAssetsNumberCardWidget extends StatelessWidget {
  const RowAssetsNumberCardWidget({
    super.key,
    required this.text,
    required this.image,
  });

  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(image, height: 24.h, width: 24.w),
        4.horizontalSpace,
        Text(
          text,
          style: AppStyles.styleMedium15(
            context,
          ).copyWith(color: AppColors.black22(context)),
        ),
      ],
    );
  }
}

class TimerContainerWidget extends StatelessWidget {
  const TimerContainerWidget({super.key, required this.auctionData});

  final AuctionData auctionData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              auctionData.status == AppStrings.auctionsOnGoing
                  ? 'ينتهي بعد'
                  : 'قادم بعد',
              style: AppStyles.styleBold14(
                context,
              ).copyWith(color: AppColors.natural50(context)),
            ),
          ),
          TimerHomeWidget(auctionData: auctionData),
        ],
      ),
    );
  }
}

class MazadDateAndTimeWidget extends StatelessWidget {
  const MazadDateAndTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white(context).withOpacity(0.7),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Row(
            children: [
              SvgPicture.asset(Assets.imagesClockCircle),
              SizedBox(width: 8),
              Text(
                'يبدأالأحد 09:00 صباحاً',
                style: AppStyles.styleBold14(context),
              ),
              Spacer(),
              Text(
                '2024/12/08',
                style: AppStyles.styleBold14(
                  context,
                ).copyWith(color: AppColors.typographyHeading(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MazadIconWidget extends StatelessWidget {
  const MazadIconWidget({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      padding: EdgeInsets.all(9),
      decoration: ShapeDecoration(
        color: const Color(0x5E0C0C0C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: FittedBox(child: SvgPicture.asset(image)),
    );
  }
}
