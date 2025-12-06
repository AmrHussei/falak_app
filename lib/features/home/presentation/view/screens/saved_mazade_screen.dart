import 'package:falak/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/widgets/adaptive_layout_widget.dart';
import 'package:falak/core/widgets/error_app_widget.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../app/app.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../core/widgets/guest_widget.dart';
import '../widgets/home/tabBar_view_body_widget.dart';
import '../widgets/mazad_card_shimmer.dart';

class SavedMazadeScreen extends StatefulWidget {
  const SavedMazadeScreen({super.key, this.title});
final String? title;
  @override
  State<SavedMazadeScreen> createState() => _SavedMazadeScreenState();
}

class _SavedMazadeScreenState extends State<SavedMazadeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getAuctions(type: AppConstant.favorite,refresh: true);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoustomAppBarWidget(title: widget.title??'المزادات المحفوظة'),
      body: KisGuest == true ? GuestWidget() : SavedMazadBodyWidget(),
    );
  }
}

class SavedMazadBodyWidget extends StatelessWidget {
  const SavedMazadBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
      child: AdaptiveLayout(
        mobileLayout: (context) => SavedMazadHomeMobileLayoute(),
        tabletLayout: (context) => SavedMazadHomeMobileLayoute(),
      ),
    );
  }
}

class SavedMazadHomeMobileLayoute extends StatelessWidget {
  const SavedMazadHomeMobileLayoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final data = state.auctionsModel[AppConstant.favorite]?.data;
        if(data!=null){
          return LoadedMobileActionHomeWidget(
            data: data,
          );
        }
        switch (state.auctionsRequestState[AppConstant.favorite]) {
          case RequestState.ideal:
          case RequestState.loading:
            return MazadCardShimmer();
          case RequestState.error:
            return ErrorAppWidget(
              onTap: () {
                context.read<HomeCubit>().getAuctions(type: AppConstant.favorite,refresh: true);
              },
              text: state.auctionsError[AppConstant.favorite]?.message??'',
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
