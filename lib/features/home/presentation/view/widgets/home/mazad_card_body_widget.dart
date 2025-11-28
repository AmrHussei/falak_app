import 'package:falak/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_bottom_card_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_image_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_title_and_location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MazadCardBodyWidget extends StatelessWidget {
  const MazadCardBodyWidget({super.key, required this.model});
  final AuctionData model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MazadImageWidget(model: model,),
          6.verticalSpace,
          MazadTitleAndLocationWidget(
            auctionData:model,
          ),
          MazadBottomCardWidget(model: model,),

        ],
      ),
    );
  }
}
