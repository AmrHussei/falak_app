import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/widgets/error_app_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_card_widget.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/auctions_model/auctions_model.dart';
import '../mazad_card_shimmer.dart';

class TabBarViewBodyWidget extends StatelessWidget {
  const TabBarViewBodyWidget({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final data = state.auctionsModel[type];
        if (data != null) {
          return LoadedMobileActionHomeWidget(data: data.data);
        }
        final currentState = state.auctionsRequestState[type];

        if (currentState == RequestState.error)
          return ErrorAppWidget(
            onTap: () {
              context.read<HomeCubit>().getAuctions(type: type);
            },
            text: state.auctionsError[type]?.message,
          );
        return const MazadCardShimmer();
      },
    );
  }
}

class LoadedMobileActionHomeWidget extends StatelessWidget {
  const LoadedMobileActionHomeWidget({
    super.key,
    required this.data,
    this.fromWinner = false,
  });

  final List<AuctionData> data;
  final bool fromWinner;

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? Center(child: const EmptyWidget(title: 'لا توجد مزادات '))
        : ListView.separated(
            separatorBuilder: (_, __) => 12.verticalSpace,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  final homeCubit = context.read<HomeCubit>();
                  homeCubit.auctionData = data[index];
                  if (data[index].auctionOrigins != null &&
                      data[index].auctionOrigins!.isNotEmpty) {
                    homeCubit.originList =
                    data[index].auctionOrigins!;
                  }
                  context.navigateTo(Routes.mazadDetailsScreen);
                },
                child: MazadCardWidget(
                  model: data[index],
                  fromWinner: fromWinner,
                  fromDetails: false,
                ),
              );
            },
            itemCount: data.length,
          );
  }
}
