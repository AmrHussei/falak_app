import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/widgets/empty_widget.dart';
import 'package:falak/core/widgets/error_app_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_card_widget.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../data/models/auctions_model/auctions_model.dart';
import '../mazad_card_shimmer.dart';

class TabBarViewBodyWidget extends StatelessWidget {
  const TabBarViewBodyWidget({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final data = state.auctionsModel?[type];

        if (data != null) {
          return LoadedMobileActionHomeWidget(auctionsModel: data);
        }
        final currentState = state.auctionsRequestState?[type];

        if (currentState == RequestState.error)
          return ErrorAppWidget(
            onTap: () {
              context.read<HomeCubit>().getAuctions(type: type);
            },
            text: state.auctionsError?[type]?.message,
          );
        return const MazadCardShimmer();
      },
    );
  }
}

class LoadedMobileActionHomeWidget extends StatelessWidget {
  const LoadedMobileActionHomeWidget({
    super.key,
    required this.auctionsModel,
    this.isFromFav = false,
  });

  final AuctionsModel auctionsModel;
  final bool isFromFav;

  @override
  Widget build(BuildContext context) {
    return auctionsModel.data.isEmpty
        ? Center(child: EmptyWidget(title: 'لا توجد مزادات '))
        : ListView.builder(
            itemBuilder: (context, index) {
              return MazadCardWidget(
                index: index,
                auctionsModel: auctionsModel,
                isFromFav: isFromFav,
              );
            },
            itemCount: auctionsModel.data.length,
          );
  }
}
