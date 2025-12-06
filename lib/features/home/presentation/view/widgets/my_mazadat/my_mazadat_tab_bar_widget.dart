import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../../core/widgets/error_app_widget.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/tabBar_view_body_widget.dart';
import '../mazad_card_shimmer.dart';

class MazadatyTabBarViewBodyWidget extends StatelessWidget {
  const MazadatyTabBarViewBodyWidget({
    super.key,
    required this.winner,
    required this.loss,
  });

  final bool winner;
  final bool loss;

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      mobileLayout: (context) =>
          MazadatyMobileLayoute(winner: winner, loss: loss),
      tabletLayout: (context) =>
          MazadatyMobileLayoute(winner: winner, loss: loss),
    );
  }
}

class MazadatyMobileLayoute extends StatelessWidget {
  const MazadatyMobileLayoute({
    super.key,
    required this.winner,
    required this.loss,
  });

  final bool winner;
  final bool loss;

  @override
  Widget build(BuildContext context) {
    final cacheKey = '${winner}_${loss}';
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final data = state.auctionsModel[cacheKey]?.data;
        if (data != null) {
          return LoadedMobileActionHomeWidget(data: data, fromWinner: winner);
        }
        switch (state.auctionsRequestState[cacheKey]) {
          case RequestState.ideal:
          case RequestState.loading:
            return MazadCardShimmer();
          case RequestState.error:
            return ErrorAppWidget(
              onTap: () {
                context.read<HomeCubit>().getAuctions(type:'${winner}_${loss}');
              },
              text: state.auctionsError[cacheKey]?.message??'',
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
