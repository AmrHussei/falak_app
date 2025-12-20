import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/widgets/empty_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/assets_details/shimmer_top_bidders_list.dart';
import 'package:falak/features/home/presentation/view/widgets/assets_details/top_bidders_card_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/error_app_widget.dart';
import '../../../view_model/home/home_cubit.dart';

class TopBiddersWidget extends StatelessWidget {
  const TopBiddersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return Container(
      height: 350.h,
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.containerGrayColor(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 0.5,
            blurRadius: 1.5,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'سجل المزايدات',
                style: AppStyles.styleMedium16(
                  context,
                ).copyWith(color: AppColors.typographyHeading(context)),
              ),
              Spacer(),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Text(
                    (state.getAuctionBoardModel?.data??[]).isEmpty
                        ? '0 مزايدين'
                        : '${(state.getAuctionBoardModel?.data??[]).length} مزايدين',
                    style: AppStyles.styleBold16(
                      context,
                    ).copyWith(color: AppColors.typographyHeading(context)),
                  );
                },
              ),
            ],
          ),
          12.verticalSpace,
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                switch (state.getAuctionBoardRequestState) {
                  case RequestState.ideal:
                  case RequestState.loading:
                    return ShimmerTopBiddersList();
                  case RequestState.error:
                    return ErrorAppWidget(
                      text: 'حدث شئ ما خطأ',
                      onTap: () {
                        homeCubit.getAuctionBoard();
                      },
                    );
                  case RequestState.loaded:
                    return (state.getAuctionBoardModel?.data??[]).isEmpty
                        ? Column(
                            children: [
                              SizedBox(height: 40),
                              EmptyWidget(
                                title: 'لا يوجد مزايدين بعد',
                                subTitle: null,
                                textButton: null,
                                onPressed: null,
                              ),
                            ],
                          )
                        : ListView.separated(
                            itemCount: (state.getAuctionBoardModel?.data??[]).length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return TopBiddersCardWidget(
                                index: index,
                                boardAuctionData: (state.getAuctionBoardModel?.data??[]),
                              );
                            },
                            separatorBuilder: (_, __) => 8.verticalSpace,
                          );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
