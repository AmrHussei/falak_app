import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';

import '../../../../../../core/functions/calculate_defrent_betwen_times.dart';
import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';
import '../../../../data/models/enrolle/auction_board_model.dart';

class TopBiddersCardWidget extends StatelessWidget {
  const TopBiddersCardWidget({
    super.key,
    required this.index,
    required this.boardAuctionData,
  });

  final int index;
  final List<BiderAuctionData> boardAuctionData;

  @override
  Widget build(BuildContext context) {
    final isTop = index == 0;
    return Container(
      height: 62.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: ShapeDecoration(
        color: isTop ? null : AppColors.backgroundPrimary(context),
        gradient: isTop
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.buttonGradientStart(context),
                  AppColors.buttonGradientEnd(context),
                ],
              )
            : null,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: index != 0
                ? AppColors.inputBorder(context)
                : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            isTop ? Assets.imagesFrame2085663780 : Assets.imagesFrame15,
            height: 38.h,
            width: 38.w,
          ),
          8.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  boardAuctionData[index].user.name,
                  maxLines: 1,
                  style: AppStyles.styleMedium13(context).copyWith(
                    color: isTop
                        ? AppColors.white(context)
                        : AppColors.inputsPlaceholder(context),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      formatNumber(boardAuctionData[index].bidAmount),
                      style: AppStyles.styleBold16(context).copyWith(
                        color: isTop
                            ? AppColors.white(context)
                            : AppColors.typographyHeading(context),
                      ),
                    ),
                    2.horizontalSpace,
                    CurrancyLogoWidget(
                      maxHeight: 15.h,
                      maxWidth: 15.w,
                      color: isTop
                          ? AppColors.white(context)
                          : AppColors.inputsPlaceholder(context),
                    ),
                  ],
                ),
                SizedBox(height: 1),
              ],
            ),
          ),
          Text(
            calculateTimeDifference(boardAuctionData[index].bidAt),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppStyles.styleMedium13(context).copyWith(
              color: isTop
                  ? AppColors.white(context)
                  : AppColors.inputsPlaceholder(context),
            ),
          ),
        ],
      ),
    );
  }
}
