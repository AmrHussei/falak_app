import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';

import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../view_model/home/home_cubit.dart';

class AssetSearchWidgetAndNum extends StatelessWidget {
  const AssetSearchWidgetAndNum({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'الاصول ( ${homeCubit.auctionData!.auctionOrigins?.length} )',
            style: AppStyles.styleBold18(
              context,
            ).copyWith(color: AppColors.typographyHeading(context)),
          ),
          32.horizontalSpace,
          Expanded(
            child: TextFormFieldWithTitleWidget(
              hint: 'البحث..',
              controller: homeCubit.originSearch,
              onChanged: (value) {
                homeCubit.searchAuctionOrigins(value);
              },
              filled: true,
              fillColor: AppColors.white(context),
              prefix: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.imagesMagnifer,
                    height: 16.h,
                    width: 16.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
