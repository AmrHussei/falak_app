import 'package:falak/features/home/presentation/view/widgets/home/home_body_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_images.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../view_model/home/home_cubit.dart';
import '../widgets/home/auctions_favorite_button.dart';
import '../widgets/mazad_menue/filter_buttom_sheet.dart';
import '../widgets/mazad_menue/mazad_menu_tab_bar_widget.dart';

class MazadatMenuScreen extends StatefulWidget {
  const MazadatMenuScreen({super.key});

  @override
  State<MazadatMenuScreen> createState() => _MazadatMenuScreenState();
}

class _MazadatMenuScreenState extends State<MazadatMenuScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);

    _tabController.addListener(() {
        String type = '';
        if (_tabController.index == 0) {
          type = AppStrings.auctionsInProgress;
        } else if (_tabController.index == 1) {
          type = AppStrings.auctionsOnGoing;
        } else {
          type = AppStrings.auctionsCompleted;
        }

        context.read<HomeCubit>().getAuctions(type:type);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      HomeCubit homeCubit = context.read<HomeCubit>();
      homeCubit.auctionFilterSearch.text = '';
      homeCubit.filterAuctiontype = null;

      homeCubit.getAuctions();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Dropdown menu items
  @override
  Widget build(BuildContext context) {
    KisFromFav = false;
    return Scaffold(
      appBar: CoustomAppBarWidget(
        title: 'قائمة المزادات',
        actions: [
          GestureDetector(
            onTap: () {
              filterSheetBottomSheet(context);
            },
            child: SvgPicture.asset(Assets.imagesSearchMenuIcon),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          MazadMenuTabBarWidget(tabController: _tabController),
          SizedBox(height: 4),
          Expanded(
            // Ensure TabBarView has space to expand
            child: HomeBodyWidget(tabController: _tabController),
          ),
        ],
      ),
    );
  }
}
