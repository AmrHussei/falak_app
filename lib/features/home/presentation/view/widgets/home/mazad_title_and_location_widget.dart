import 'package:cached_network_image/cached_network_image.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../data/models/auctions_model/auctions_model.dart';

class MazadTitleAndLocationWidget extends StatelessWidget {
  const MazadTitleAndLocationWidget({super.key, required this.auctionData});

  final AuctionData auctionData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          auctionData.title ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: AppStyles.styleBold16(
            context,
          ).copyWith(color: AppColors.black22(context)),
        ),
        6.verticalSpace,
        Row(
          children: [
            SvgPicture.asset(Assets.imagesLocation, width: 18.w, height: 16.h),
           2.horizontalSpace, Text(
              auctionData.location.title ?? '',
              maxLines: 1,
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: AppColors.secondColor(context)),
            ),
          ],
        ),
      ],
    );
  }
}

class CachedNetworkImageWidegt extends StatelessWidget {
  const CachedNetworkImageWidegt({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => CustomCircularProgressIndicatorWidget(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

class CustomCircularProgressIndicatorWidget extends StatelessWidget {
  const CustomCircularProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        strokeWidth: 5,
        color: AppColors.primary(context),
      ),
    );
  }
}
