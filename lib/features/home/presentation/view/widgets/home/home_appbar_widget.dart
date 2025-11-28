import 'package:falak/core/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';
import 'package:falak/app/app.dart';
import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../paegs/presentation/view_model/pages_cubit.dart';

class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarWidget({
    super.key,
    required this.tabController,
    required this.toggleDrawer,
  });

  final TabController tabController;

  final Function() toggleDrawer;

  @override
  Size get preferredSize => Size.fromHeight(108.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: CustomTabBar(
        controller: tabController,
        tabs: ['مستقبلي', 'قائم', 'منتهية'],
      ),
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      title: SvgPicture.asset(AppAssets.app_imagesLogoName, height: 34.26.h),
      toolbarHeight: 64.h,
      leading: Padding(
        padding: EdgeInsetsDirectional.only(start: 16),
        child: InkWell(
          onTap: toggleDrawer,
          child: SvgPicture.asset(
            AppAssets.app_imagesMenu,
            fit: BoxFit.contain,
          ),
        ),
      ),
      leadingWidth: 60,
      actions: [
        KisGuest
            ? GestureDetector(
                onTap: () {
                  showPopover(
                    context: context,
                    bodyBuilder: (context) => Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: ListItems(),
                    ),
                    onPop: () => print('Popover was popped!'),
                    direction: PopoverDirection.bottom,
                    width: 252,
                    height: 200,
                    arrowHeight: 16,
                    arrowDxOffset: -16,
                    barrierColor: Colors.transparent,
                    arrowDyOffset: -60,
                    arrowWidth: 0,
                    backgroundColor: const Color(0xFF2F4A6F),
                  );
                },
                child: Container(
                  width: 44,
                  height: 44,
                  padding: const EdgeInsets.all(8),
                  decoration: ShapeDecoration(
                    color: AppColors.secondColor(context),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: const Color(0xFFE1E1E2),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: FittedBox(
                    child: SvgPicture.asset(
                      Assets.imagesUser,
                      fit: BoxFit.contain,
                      color: AppColors.white(context),
                    ),
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  context.navigateTo(Routes.notificationScreen);
                },
                child: BlocBuilder<PagesCubit, PagesState>(
                  builder: (context, state) {
                    final count = context
                        .watch<PagesCubit>()
                        .state
                        .notificationCount;
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(
                          Assets.imagesBell,
                          fit: BoxFit.contain,
                          width: 44,
                          height: 44,
                        ),
                        if (count != 0 && count != null && KisGuest == false)
                          PositionedDirectional(
                            top: 0,
                            start: 0,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.mainColor(context),
                                ),
                                padding: EdgeInsets.all(4),
                                child: Center(
                                  child: Text(
                                    '${count}',
                                    style: AppStyles.stylBold12(context)
                                        .copyWith(
                                          color: AppColors.typographyHeading(
                                            context,
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
        SizedBox(width: 16),
      ],
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          MenuItemCard(
            iconAsset: AppAssets.app_imagesUserCheckRounded,
            title: 'أفراد',
            onTap: () {
              context.navigateTo(Routes.login);
              // Your action here
            },
          ),
          SizedBox(height: 12),
          MenuItemCard(
            iconAsset: AppAssets.app_imagesUserPlusRounded,
            title: 'إنشاء حساب (أفراد)',
            onTap: () {
              context.navigateTo(Routes.signUpScreen);
              // Your action here
            },
          ),
          SizedBox(height: 12),
          MenuItemCard(
            iconAsset: AppAssets.app_imagesAddSales,
            title: 'إنشاء حساب (وكلاء البيع)',
            onTap: () {
              context.navigateTo(Routes.SalesAgentIntroScreen);
              // Your action conthere
            },
          ),
        ],
      ),
    );
  }
}

class MenuItemCard extends StatelessWidget {
  final String iconAsset;
  final String title;
  final VoidCallback onTap;

  const MenuItemCard({
    Key? key,
    required this.iconAsset,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: ShapeDecoration(
          color: AppColors.primary(context),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconAsset),
            const SizedBox(width: 8),
            Text(
              title,
              textAlign: TextAlign.right,
              style: AppStyles.styleMedium14(
                context,
              ).copyWith(color: AppColors.white(context)),
            ),
            const SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: const Stack(),
            ),
          ],
        ),
      ),
    );
  }
}
