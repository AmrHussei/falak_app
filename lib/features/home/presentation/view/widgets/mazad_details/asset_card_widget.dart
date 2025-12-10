import 'package:falak/core/utils/app_strings.dart';
import 'package:falak/core/utils/constant.dart';
import 'package:falak/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/coming_origin_buttons_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/coming_origin_texts_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/ended_origin_buttons_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/on_going_origin_buttons_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/on_going_origin_texts_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/asset_title_and_location_widget.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../view_model/home/home_cubit.dart';

class AssetCardWidget extends StatelessWidget {
  const AssetCardWidget({
    super.key,
    required this.origin,
    required this.index,
    required this.model,
  });

  final AuctionOrigin origin;
  final int index;
  final AuctionData model;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return GestureDetector(
      onTap: () {
        homeCubit.auctionOrigin = origin;
        KoriginId = origin.id;

        context.navigateTo(Routes.assetsDetailsScreen);
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(
          bottom: 24.h,
          end: 16.w,
          start: 16.w,
        ),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: const Color(0xFFD7DBD7)),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Column(
          children: [
            AssetTitleAndLocationWidget(origin: origin, index: index),
            8.verticalSpace,
            Divider(),
            12.verticalSpace,
            if (model.status == AppStrings.auctionsInProgress)
              ComingOriginTextsWidget(origin: origin, model: model)
            else
              OnGoingOriginTextsWidget(origin: origin, model: model),
            12.verticalSpace,
            Divider(),
            12.verticalSpace,
            if (model.status == AppStrings.auctionsInProgress)
              ComingOriginButtonsWidget(origin: origin)
            else if (model.status == AppStrings.auctionsOnGoing)
              OnGoingOriginButtonsWidget(origin: origin)
            else if (model.status == AppStrings.auctionsCompleted)
              EndedOriginButtonsWidget(origin: origin),
          ],
        ),
      ),
    );
  }
}

class AssetDepositScreen extends StatelessWidget {
  AssetDepositScreen({
    super.key,
    required this.title,
    required this.desc,
    this.descColor,
  });

  final String title, desc;
  Color? descColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.styleBold14(
            context,
          ).copyWith(color: AppColors.typographySubTitle(context)),
        ),
        SizedBox(height: 4),
        Text(
          desc,
          style: AppStyles.styleBold14(context).copyWith(
            color: descColor ?? AppColors.typographyHeading(context),
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

String formatDateFunction(String isoDate) {
  DateTime dateTime = DateTime.parse(isoDate);

  if (AppConstant.KisHijri) {
    HijriCalendar hijriDate = HijriCalendar.fromDate(dateTime);
    return '${hijriDate.hYear}/${hijriDate.hMonth.toString().padLeft(2, '0')}/${hijriDate.hDay.toString().padLeft(2, '0')}';
  } else {
    return '${dateTime.year}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}';
  }
}

String formatTimeFunction(String isoDate) {
  DateTime dateTime = DateTime.parse(
    isoDate,
  ).toLocal(); // Convert to local time
  int hour = dateTime.hour;
  String period = hour < 12 ? 'صباحاً' : 'مساءً';
  hour = hour % 12;
  hour = hour == 0 ? 12 : hour; // Handle 12-hour format
  String formattedTime =
      '${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} $period';
  return formattedTime;
}
