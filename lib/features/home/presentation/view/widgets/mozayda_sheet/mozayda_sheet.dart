import 'package:falak/core/widgets/custom_tab_bar.dart';
import 'package:falak/core/widgets/global_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/home/presentation/view/widgets/assets_details/top_bidders_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/mozayda_sheet/mozayda_board_widget.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../../generated/assets.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';
import '../../../../../profile/presentation/view_model/profile/profile_cubit.dart';
import '../../../view_model/home/home_cubit.dart';

Future<void> mozaydaSheetBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (context) {
      return mozaydaSheetBottomSheetBodyWidget();
    },
  );
}

class mozaydaSheetBottomSheetBodyWidget extends StatefulWidget {
  const mozaydaSheetBottomSheetBodyWidget({super.key});

  @override
  State<mozaydaSheetBottomSheetBodyWidget> createState() =>
      _mozaydaSheetBottomSheetBodyWidgetState();
}

class _mozaydaSheetBottomSheetBodyWidgetState
    extends State<mozaydaSheetBottomSheetBodyWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getAgencies();
    context.read<HomeCubit>().getWallet();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return GlobalBottomSheet(
          padding: 8.w,
          title: 'لوحة المزايدة',
          action: () {
            context.pop();
          },
          height: 610.h,
          child: Expanded(
            child: Column(
              children: [
                CustomTabBar(
                  controller: _tabController,
                  tabs: ['لوحة المزايدة', 'المزايدين'],
                  haveWidth: false,
                ),
                12.verticalSpace,
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [MozaydaBoardWidget(), TopBiddersWidget()],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TopMozaydaWidget extends StatelessWidget {
  const TopMozaydaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: ShapeDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.buttonGradientStart(context),
                  AppColors.buttonGradientEnd(context),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.imagesFrame2085663780,
                  height: 38.h,
                  width: 38.w,
                ),
                8.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'أعلى مزايدة',
                        maxLines: 1,
                        style: AppStyles.styleMedium15(
                          context,
                        ).copyWith(color: AppColors.white(context)),
                      ),
                      BlocBuilder<HomeCubit,HomeState>(
                        builder: (_,_) {
                          return Row(
                            children: [
                              Flexible(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    homeCubit.boardAuctionData.isEmpty
                                        ? 'لا يوجد مزايدين بعد'
                                        : formatNumber(
                                            homeCubit
                                                .boardAuctionData
                                                .first
                                                .bidAmount,
                                          ),
                                    style: AppStyles.styleBold18(
                                      context,
                                    ).copyWith(color: AppColors.white(context)),
                                  ),
                                ),
                              ),
                              2.horizontalSpace,
                              CurrancyLogoWidget(
                                maxHeight: 15.h,
                                maxWidth: 15.w,
                                color: AppColors.white(context),
                              ),
                            ],
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: SizedBox(
            height: 50.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'فرق السوم',
                  textAlign: TextAlign.start,
                  style: AppStyles.styleMedium15(
                    context,
                  ).copyWith(color: AppColors.inputsPlaceholder(context)),
                ),
                4.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      formatNumber(homeCubit.auctionOrigin!.garlicDifference),
                      textAlign: TextAlign.start,
                      style: AppStyles.styleMedium16(
                        context,
                      ).copyWith(color: AppColors.typographyHeading(context)),
                    ),
                    2.horizontalSpace,
                    CurrancyLogoWidget(
                      color: AppColors.typographyHeading(context),
                      maxHeight: 15.h,
                      maxWidth: 15.w,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
