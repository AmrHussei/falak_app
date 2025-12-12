import 'package:falak/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../generated/assets.dart';

class AssetsDetailsWidget extends HookWidget {
  final Detail detail;

  const AssetsDetailsWidget({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final show = useState(false);
    return ExpansionTile(
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: const Color(0xffE7E9E9)),
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: const Color(0xffE7E9E9)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      trailing: SvgPicture.asset(
        show.value ? Assets.imagesArrowTop : Assets.imagesArrowBottom,
        height: 24.h,
        width: 24.w,
      ),

      title: Text(
        detail.title ?? '',
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: show.value
            ? AppStyles.styleMedium14(
                context,
              ).copyWith(color: AppColors.typographyHeading(context))
            : AppStyles.styleRegular14(
                context,
              ).copyWith(color: AppColors.grayText(context)),
      ),
      onExpansionChanged: (value) {
        show.value = value;
      },
      childrenPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      children: detail.auctionDetails
          .map(
            (itemDetail) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(itemDetail.title ?? ''),
                  Text(itemDetail.description ?? ''),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
