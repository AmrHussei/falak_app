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
    required this.model,
    required this.fromWinner,
    required this.fromDetails,
  });

  final AuctionData model;
  final bool fromWinner;
  final bool fromDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: fromDetails?1:5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(fromDetails ? 0 : 16.r),
      ),
      child: MazadCardBodyWidget(
        model: model,
        fromWinner: fromWinner,
        fromDetails: fromDetails,
      ),
    );
  }
}
