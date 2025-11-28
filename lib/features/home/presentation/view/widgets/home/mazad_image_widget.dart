import 'package:falak/app/app.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_title_and_location_widget.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MazadImageWidget extends StatelessWidget {
  const MazadImageWidget({super.key, required this.model});

  final AuctionData model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 209.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImageWidegt(
            imageUrl: model.cover ?? '',
            width: double.infinity,
            height: 209.h,
          ),
        ),
        PositionedDirectional(
          top: 10.h,
          end: 8.w,
          child: Container(
            height: 36.h,
            width: 88.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.black(context),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                model.type == 'online'
                    ? 'مزاد الكتروني'
                    : model.type == 'hybrid'
                    ? 'مزاد هجين'
                    : 'مزاد حضوري',
                style: AppStyles.styleMedium12(
                  context,
                ).copyWith(color: AppColors.white(context)),
              ),
            ),
          ),
        ),
        if (!KisGuest)
          PositionedDirectional(
            top: 12.h,
            start: 10.w,
            child: SvgPicture.asset(
              model.isFavorite == true
                  ? Assets.appImagesLikedHeart
                  : Assets.appImagesFavoriteAuction,
              height: 32.h,
              width: 32.w,
            ),
          ),
      ],
    );
  }
}
