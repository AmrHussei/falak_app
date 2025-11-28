import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/features/home/presentation/view/screens/assets_details_screen.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../../core/widgets/error_app_widget.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/tabBar_view_body_widget.dart';
import '../mazad_card_shimmer.dart';

class MazadatyTabBarViewBodyWidget extends StatelessWidget {
  const MazadatyTabBarViewBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 16,
        end: 16,
      ),
      child: AdaptiveLayout(
          mobileLayout: (context) => MazadatyMobileLayoute(),
          tabletLayout: (context) => MazadatyMobileLayoute()),
    );
  }
}

class MazadatyMobileLayoute extends StatelessWidget {
  const MazadatyMobileLayoute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.getUserAuctionsRequestState) {
          case RequestState.ideal:
          case RequestState.loading:
            return MazadCardShimmer();
          case RequestState.error:
            return ErrorAppWidget(
              onTap: () {
                context.read<HomeCubit>().getUserAuctions();
              },
              text: state.getUserAuctionsError!.message,
            );
          case RequestState.loaded:
            return LoadedMobileActionHomeWidget(
              auctionsModel: state.getUserAuctionsModel!,
            );
        }
      },
    );
  }
}
