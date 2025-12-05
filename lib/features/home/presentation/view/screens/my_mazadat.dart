import 'package:falak/core/widgets/coustom_app_bar_widget.dart';
import 'package:falak/core/widgets/custom_tab_bar.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../app/app.dart';
import '../../../../../core/widgets/guest_widget.dart';
import '../../view_model/home/home_cubit.dart';
import '../widgets/home/auctions_favorite_button.dart';
import '../widgets/my_mazadat/my_mazadat_tab_bar_widget.dart';

class MyMazadatScreen extends StatefulWidget {
  const MyMazadatScreen({super.key});

  @override
  State<MyMazadatScreen> createState() => _MyMazadatScreenState();
}

class _MyMazadatScreenState extends State<MyMazadatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    HomeCubit homeCubit = context.read<HomeCubit>();
    homeCubit.getUserAuctions(false, false);

    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener(() {
      bool winner = false;
      bool loss = false;
      if (_tabController.index == 0) {
        winner = false;
        loss = false;
      } else if (_tabController.index == 1) {
        winner = true;
        loss = false;
      } else {
        winner = false;
        loss = true;
      }

      homeCubit.getUserAuctions(winner, loss);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String? selectedValue;

  // Dropdown menu items
  @override
  Widget build(BuildContext context) {
    KisFromFav = false;
    return Scaffold(
      appBar: CoustomAppBarWidget(
        titleWidget: SvgPicture.asset(
          Assets.appImagesLogoName,
          height: 34.26.h,
          width: 122.w,
        ),
        leading: SizedBox.shrink(),
      ),
      body: KisGuest == true
          ? GuestWidget()
          : Column(
              children: [
                CustomTabBar(
                  controller: _tabController,
                  haveWidth: false,
                  tabs: ['إشتراكاتي', 'مزاداتي الرابحة', 'مزاداتي الخاسرة'],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      MazadatyTabBarViewBodyWidget(winner: false, loss: false),
                      MazadatyTabBarViewBodyWidget(winner: true, loss: false),
                      MazadatyTabBarViewBodyWidget(winner: false, loss: true),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
