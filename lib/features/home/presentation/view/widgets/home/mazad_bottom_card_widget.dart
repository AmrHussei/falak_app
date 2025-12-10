import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_images.dart';
import 'package:falak/core/utils/app_strings.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_status_timer_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/home/show_more_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/download_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/my_mazadat/winner_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MazadBottomCardWidget extends StatelessWidget {
  const MazadBottomCardWidget({
    super.key,
    required this.model,
    this.fromWinner = false,
    required this.fromDetails,
  });

  final AuctionData model;
  final bool fromWinner;
  final bool fromDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      elevation: 5,
      color: const Color(0xffF9FAFA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      shadowColor: const Color(0xffF4F4F4),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          children: [
            if (fromWinner)
              const WinnerWidget()
            else if (model.status == AppStrings.auctionsInProgress ||
                model.status == AppStrings.auctionsOnGoing)
              MazadStatusTimerWidget(auctionData: model)
            else
              Container(
                height: 46.h,
                width: 323.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Color(0xffFFEDEA),
                  border: Border.all(color: Color(0xffF9FAFA)),
                ),
                alignment: AlignmentDirectional.center,
                child: Text('مزاد منتهي',style: AppStyles.styleMedium14(context).copyWith(
                  color: AppColors.error(context)
                ),),
              ),

            Divider(height: 32.h, thickness: 1, color: const Color(0xffE7E9E9)),
            if (fromDetails)
              const DownloadWidget()
            else
              ShowMoreWidget(
                auctionOriginsNum: model.auctionOrigins?.length ?? 0,
                auctionData: model,
              ),
          ],
        ),
      ),
    );
  }
}
