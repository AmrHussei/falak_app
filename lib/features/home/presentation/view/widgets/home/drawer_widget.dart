import 'package:falak/features/home/presentation/view/widgets/home/guest_drawer_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/home/user_drawer_widget.dart';
import 'package:falak/features/wallet/presentation/view_model/wallet/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_images.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';

import '../../../../../../app/app.dart';
import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/app_colors.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({super.key, required this.toggleDrawer});

  final Function() toggleDrawer;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WalletCubit>().getWallet();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List drawerList = [
      {
        'text': 'قائمة المزادات',
        'image': AppAssets.app_imagesGavelLawBlackIcon,
        'onTap': () {
          context.navigateTo(Routes.mazadatMenuScreen);
        },
      },
      if (!KisGuest)
        {
          'text': 'المزادات المحفوظة',
          'image': AppAssets.app_imagesFavoriteAuction,
          'onTap': () {
            context.navigateTo(Routes.savedMazadeScreen);
          },
        },

      {
        'text': 'تواصل معنا',
        'image': AppAssets.app_imagesContactUs,
        'onTap': () {
          context.navigateTo(Routes.contactUsScreen);
        },
      },
      {
        'text': 'الأسئلة الشائعة',
        'image': AppAssets.app_imagesQuestionCircle,
        'onTap': () {
          context.navigateTo(Routes.qustionScreen);
        },
      },
      {
        'text': 'وكيل البيع',
        'image': AppAssets.app_imagesAddSales,
        'onTap': () {
          context.navigateTo(Routes.addSalesAgent);
        },
      },
      {
        'text': 'الشروط و الاحكام',
        'image': AppAssets.app_imagesDocument,
        'onTap': () {
          context.navigateTo(Routes.policyScreen);
        },
      },
    ];

    return Drawer(
      backgroundColor: AppColors.white(context),
      shape: LinearBorder(),
      width: 0.714.sw,

      child: Column(
        children: [
          SizedBox(height: context.topPadding),
          Row(
            children: [
              12.horizontalSpace,
              Image.asset(
                AppAssets.app_imagesAppLogo,
                height: 44.95.h,
                width: 83.w,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              12.horizontalSpace,
              InkWell(
                onTap: () {
                  widget.toggleDrawer();
                },
                child: SvgPicture.asset(Assets.imagesClose, height: 20.h),
              ),
              12.horizontalSpace,
            ],
          ),
          16.verticalSpace,
          DrawerDividerWidget(),
          24.verticalSpace,
          if (KisGuest)
            GuestDrawerWidget(toggleDrawer: widget.toggleDrawer)
          else
            UserDrawerWidget(toggleDrawer: widget.toggleDrawer),
          24.verticalSpace,
          DrawerDividerWidget(),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: drawerList.length,
              itemBuilder: (context, index) {
                return ListTileWidget(
                  image: drawerList[index]['image'],
                  text: drawerList[index]['text'],
                  onTap: drawerList[index]['onTap'],
                );
              },
            ),
          ),
          Text('Version 0.1'),
          24.verticalSpace,
        ],
      ),
    );
  }
}

class DrawerDividerWidget extends StatelessWidget {
  const DrawerDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: AppColors.borderPrimary(context), height: 1);
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
  });

  final String text;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: SvgPicture.asset(image, width: 24.w, height: 24.h),
          title: Text(
            text,
            textAlign: TextAlign.start,
            style: AppStyles.styleRegular15(
              context,
            ).copyWith(color: AppColors.grayText(context), height: 1.33),
          ),
          onTap: onTap,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: DrawerDividerWidget(),
        ),
      ],
    );
  }
}
