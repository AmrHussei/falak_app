import 'package:falak/features/home/presentation/view/widgets/home/mazad_card_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../data/models/auctions_model/auctions_model.dart';
import '../../../view_model/home/home_cubit.dart';


class MazadCardWidget extends StatelessWidget {
  const MazadCardWidget({
    super.key,
    required this.index,
    required this.auctionsModel,
  });

  final AuctionsModel auctionsModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final model = auctionsModel.data[index];
    return GestureDetector(
      onTap: () {
        final homeCubit = context.read<HomeCubit>();
        homeCubit.auctionData = model;
        homeCubit.originList = model.auctionOrigins;
        context.navigateTo(Routes.mazadDetailsScreen);
      },
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: MazadCardBodyWidget(model: model),
      ),
    );
  }
}
