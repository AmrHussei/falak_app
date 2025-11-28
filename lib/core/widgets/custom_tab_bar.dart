import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/widgets/gradient_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final List<String> tabs;

  const CustomTabBar({super.key, required this.controller, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      indicator: GradientUnderlineTabIndicator(
        borderSide: BorderSide(
          color: AppColors.secondColor(context),
          width: 1.5.h,
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            AppColors.buttonGradientEnd(context).withValues(alpha: 0.1),
          ],
        ),
      ),
      unselectedLabelColor: Colors.black,
      labelStyle: AppStyles.styleBold14(
        context,
      ).copyWith(color: AppColors.secondColor(context)),
      unselectedLabelStyle: AppStyles.styleMedium14(
        context,
      ).copyWith(color: AppColors.typographyHeading(context)),
      indicatorSize: TabBarIndicatorSize.tab,
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      tabs: tabs
          .map(
            (title) => Tab(
              child: SizedBox(width: 65.w, child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title),
                ],
              )),
            ),
          )
          .toList(),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 52.h);
}
