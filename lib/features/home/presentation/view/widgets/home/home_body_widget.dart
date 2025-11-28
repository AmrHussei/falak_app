import 'package:falak/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'tabBar_view_body_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key, required TabController tabController})
    : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: [
        TabBarViewBodyWidget(type: AppStrings.auctionsInProgress),
        TabBarViewBodyWidget(type: AppStrings.auctionsOnGoing),
        TabBarViewBodyWidget(type: AppStrings.auctionsCompleted),
      ],
    );
  }
}
