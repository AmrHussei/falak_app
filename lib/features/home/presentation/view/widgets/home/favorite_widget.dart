import 'package:falak/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../generated/assets.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key, required this.model});

  final AuctionData model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeCubit>().toggleFavoriteAuction(model.id,!(model.isFavorite??false));
      },
      child: SvgPicture.asset(
        model.isFavorite == true
            ? Assets.appImagesLikedHeart
            : Assets.appImagesFavoriteAuction,
        height: 32.h,
        width: 32.w,
      ),
    );
  }
}
