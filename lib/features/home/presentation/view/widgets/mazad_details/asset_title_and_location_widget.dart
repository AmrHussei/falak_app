import 'package:flutter/material.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../data/models/auctions_model/auctions_model.dart';

class AssetTitleAndLocationWidget extends StatelessWidget {
  const AssetTitleAndLocationWidget({
    super.key,
    required this.origin,
    required this.index,
  });

  final AuctionOrigin origin;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          color: AppColors.white(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),

          child: SizedBox(
            height: 36.h,
            width: 36.w,
            child: Center(
              child: Text(
                (index + 1).toString(),
                style: AppStyles.styleBold16(
                  context,
                ).copyWith(color: AppColors.titleColor(context)),
              ),
            ),
          ),
        ),
        12.horizontalSpace,
        Flexible(
          child: Text(
            origin.title ?? 'اسم الاصل',
            maxLines: 2,
            style: AppStyles.styleSemiBold16(
              context,
            ).copyWith(color: AppColors.typographyHeading(context)),
          ),
        ),
      ],
    );
  }
}
