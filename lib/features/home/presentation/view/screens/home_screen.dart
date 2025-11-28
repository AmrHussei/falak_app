import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/features/home/presentation/view/widgets/home/home_appbar_widget.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../paegs/presentation/view_model/pages_cubit.dart';
import '../widgets/home/auctions_favorite_button.dart';
import '../widgets/home/home_body_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void toggleDrawer() {
  if (homeScaffoldKey.currentState?.isDrawerOpen ?? false) {
    homeScaffoldKey.currentState?.closeDrawer();
  } else {
    homeScaffoldKey.currentState?.openDrawer();
  }
}

final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen>
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

        context.read<HomeCubit>().getAuctions(type: type);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.wait([
        context.read<PagesCubit>().getUnReadCount(),
        context.read<HomeCubit>().getAuctions(),
      ]);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    KisFromFav = false;
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary(context),
      appBar: HomeAppBarWidget(
        tabController: _tabController,
        toggleDrawer: toggleDrawer,
      ),
      body: HomeBodyWidget(tabController: _tabController),
    );
  }
}
