import 'package:falak/core/functions/format_number.dart';
import 'package:falak/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/row_widget.dart'
    show RowWidget;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../generated/assets.dart';

class OnGoingOriginTextsWidget extends StatelessWidget {
  const OnGoingOriginTextsWidget({
    super.key,
    required this.origin,
    required this.model,
  });

  final AuctionOrigin origin;
  final AuctionData model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RowWidget(
          title: 'أعلى مزايدة',
          subTitle: formatNumber(origin.highestBid??0),
          icon: Assets.appImagesSquareDouble,
          subIcon: Assets.imagesRiyal,
        ),
        12.verticalSpace,
        RowWidget(
          title: 'عربون الدخول',
          subTitle: formatNumber(origin.entryDeposit),
          icon: Assets.appImagesBillCheck,
          subIcon: Assets.imagesRiyal,
        ),
      ],
    );
  }
}
