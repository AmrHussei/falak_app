import 'package:falak/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_bottom_card_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_image_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_title_and_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MazadCardBodyWidget extends StatelessWidget {
  const MazadCardBodyWidget({
    super.key,
    required this.model,
    required this.fromWinner,
    required this.fromDetails,
  });

  final AuctionData model;
  final bool fromWinner;
  final bool fromDetails;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        6.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: fromDetails ? 0 : 10.w),

          child: MazadImageWidget(model: model, fromDetails: fromDetails),
        ),
        6.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),

          child: Column(
            children: [
              MazadTitleAndLocationWidget(auctionData: model),
              MazadBottomCardWidget(
                model: model,
                fromWinner: fromWinner,
                fromDetails: fromDetails,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
