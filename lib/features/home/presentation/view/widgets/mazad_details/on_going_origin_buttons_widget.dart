import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:falak/features/home/presentation/view/widgets/mozayda_sheet/mozayda_sheet.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnGoingOriginButtonsWidget extends StatelessWidget {
  const OnGoingOriginButtonsWidget({super.key, required this.origin});
  final AuctionOrigin origin;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppOutlinedButton(
            onPressed: () {
              context.read<HomeCubit>().auctionOrigin = origin;
              KoriginId = origin.id;

              context.navigateTo(Routes.assetsDetailsScreen);
            },
            text: 'التفاصيل',
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: AppPrimaryButton(
            icon: Assets.appImagesLeaflet,
            onPressed: () async{
              HomeCubit homeCubit = context.read<HomeCubit>();
              homeCubit.auctionOrigin = origin;
              KoriginId = origin.id;
              homeCubit.auctionId = homeCubit.auctionData!.id;
              homeCubit.originId = homeCubit.auctionOrigin!.id;
              homeCubit.amount = null;
              await homeCubit.getAuctionBoard();
              context.read<HomeCubit>().addNewBidValue();
              mozaydaSheetBottomSheet(context);
            },
            text: 'لوحة المزايدة',
          ),
        ),
      ],
    );
  }
}
