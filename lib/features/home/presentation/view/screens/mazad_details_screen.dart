import 'package:falak/features/home/presentation/view/widgets/home/mazad_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/widgets/coustom_app_bar_widget.dart';
import 'package:falak/core/widgets/empty_widget.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../view_model/home/home_cubit.dart';
import '../widgets/mazad_details/asset_card_widget.dart';
import '../widgets/mazad_details/asset_search_widget_and_num.dart';

class MazadDetailsScreen extends StatefulWidget {
  const MazadDetailsScreen({super.key});

  @override
  State<MazadDetailsScreen> createState() => _MazadDetailsScreenState();
}

class _MazadDetailsScreenState extends State<MazadDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Scaffold(
      backgroundColor: AppColors.white(context),
      appBar: CoustomAppBarWidget(
        title: homeCubit.auctionData?.title ?? 'تفاصيل المزاد',
        actions: [
          homeCubit.auctionData?.status == AppStrings.auctionsOnGoing
              ? AuctionDetailsOnGoingStutesWidget()
              : homeCubit.auctionData?.status == AppStrings.auctionsInProgress
              ? AuctionDetailsInprogressStutesWidget()
              : AuctionDetailsCompletedStutesWidget(),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: MazadCardWidget(
              model: homeCubit.auctionData!,
              fromWinner: false,
              fromDetails: true,
            ),
          ),
          SliverToBoxAdapter(child: 16.verticalSpace),
          SliverToBoxAdapter(child: AssetSearchWidgetAndNum()),
          SliverToBoxAdapter(child: 16.verticalSpace),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return homeCubit.originList.isEmpty
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: EmptyWidget(title: 'لا يوجد اصول بهذا الاسم'),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return AssetCardWidget(
                          origin: homeCubit.originList[index],
                          index: index,
                          model:homeCubit.auctionData!
                        );
                      }, childCount: homeCubit.originList.length),
                    );
            },
          ),
        ],
      ),
    );
  }
}

class AuctionDetailsInprogressStutesWidget extends StatelessWidget {
  const AuctionDetailsInprogressStutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      width: 72.w,
      alignment: Alignment.center,
      margin: EdgeInsetsDirectional.only(end: 16.w),
      decoration: ShapeDecoration(
        color: const Color(0xffFCFAF5),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFFFAE38D)),
          borderRadius: BorderRadius.circular(10.w),
        ),
      ),
      child: Text(
        'مستقبلي',
        style: AppStyles.styleMedium13(
          context,
        ).copyWith(color: const Color(0xFFEF9A11)),
      ),
    );
  }
}

class AuctionDetailsCompletedStutesWidget extends StatelessWidget {
  const AuctionDetailsCompletedStutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      width: 84.w,
      alignment: Alignment.center,
      margin: EdgeInsetsDirectional.only(end: 16.w),
      decoration: ShapeDecoration(
        color: const Color(0x1aBD2915),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0x57BD2915)),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Center(
        child: Text(
          'مزاد منتهي',
          style: AppStyles.styleMedium13(
            context,
          ).copyWith(color: const Color(0xFFBD2915)),
        ),
      ),
    );
  }
}

class AuctionDetailsOnGoingStutesWidget extends StatelessWidget {
  const AuctionDetailsOnGoingStutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.h,
      width: 78.w,
      alignment: Alignment.center,
      margin: EdgeInsetsDirectional.only(end: 16.w),
      decoration: ShapeDecoration(
        color: const Color(0xffF3FBEE),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0x4A009951)),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.app_imagesOnGoing,
            height: 32.h,
            width: 32.w,
          ),
          4.horizontalSpace,
          Text(
            'قائم',
            style: AppStyles.styleMedium16(
              context,
            ).copyWith(color: const Color(0xff009951)),
          ),
        ],
      ),
    );
  }
}
