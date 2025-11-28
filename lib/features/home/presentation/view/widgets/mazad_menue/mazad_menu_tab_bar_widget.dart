import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MazadMenuTabBarWidget extends StatelessWidget {
  const MazadMenuTabBarWidget({super.key, required TabController tabController})
    : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundPrimary(context),
      child: Container(
        padding: EdgeInsets.only(top: 8.h, right: 16.w, left: 16.w),
        decoration: BoxDecoration(
          color: AppColors.white(context),
          border: Border(
            top: BorderSide(color: AppColors.strockSheen(context), width: 1.0),
            bottom: BorderSide(
              color: AppColors.strockSheen(context),
              width: 1.0,
            ),
          ),
        ),
        child: CustomTabBar(
          controller: _tabController,
          tabs: ['مستقبلي', 'قائم', 'منتهية'],
        ),
      ),
    );
  }
}
