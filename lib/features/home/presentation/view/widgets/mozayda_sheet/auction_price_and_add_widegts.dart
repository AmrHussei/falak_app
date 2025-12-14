import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/home/presentation/view/widgets/mozayda_sheet/call_to_action_add_mozayda_widget.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/utils/images.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';
import '../../../view_model/home/home_cubit.dart';
import '../assets_details/logout_auction_sheet.dart';

class AuctionPriceWidegt extends StatelessWidget {
  const AuctionPriceWidegt({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        dynamic price = homeCubit.boardAuctionData.isEmpty
            ? homeCubit.auctionOrigin!.openingPrice
            : homeCubit.boardAuctionData.first.bidAmount;
        dynamic propertyPrice = price;
        dynamic transactionFee = price * 0.05;
        dynamic commission = price * 0.025;
        dynamic commissionTax = commission * 0.25;

        dynamic total = price + transactionFee + commission + commissionTax;
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white(context),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Color(0x0D000000)),
              ),
              child: Column(
                children: [
                  homeCubit.auctionOrigin != null &&
                          homeCubit.auctionOrigin!.details.length > 1 &&
                          homeCubit
                              .auctionOrigin!
                              .details[1]
                              .auctionDetails
                              .isNotEmpty &&
                          int.tryParse(
                                homeCubit
                                        .auctionOrigin!
                                        .details[1]
                                        .auctionDetails[0]
                                        .description ??
                                    '',
                              ) !=
                              null
                      ? PriceingRowTextWidget(
                          title: 'سعر المتر',
                          price:
                              '${formatNumber(propertyPrice / num.parse(homeCubit.auctionOrigin!.details[1].auctionDetails[0].description!))}',
                        )
                      : SizedBox.shrink(),
                  Divider(),
                  PriceingRowTextWidget(
                    title: 'مبلغ السعي',
                    price: '${formatNumber(commission)}',
                  ),
                  Divider(),
                  PriceingRowTextWidget(
                    title: 'ضريبة السعي',
                    price: '${formatNumber(commissionTax)}',
                  ),
                  Divider(),
                  PriceingRowTextWidget(
                    title: 'ضريبة العقار',
                    price: '${formatNumber(transactionFee)}',
                  ),
                  Divider(),
                ],
              ),
            ),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الإجمالي',
                  textAlign: TextAlign.start,
                  style: AppStyles.styleBold16(
                    context,
                  ).copyWith(color: AppColors.typographyBody(context)),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${formatNumber(total)}',
                      textAlign: TextAlign.start,
                      style: AppStyles.styleSemiBold18(
                        context,
                      ).copyWith(color: AppColors.secondColor(context)),
                    ),
                    2.horizontalSpace,
                    CurrancyLogoWidget(
                      color: AppColors.secondColor(context),
                      maxHeight: 15.h,
                      maxWidth: 15.w,
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class PriceingRowTextWidget extends StatelessWidget {
  PriceingRowTextWidget({
    super.key,
    required this.title,
    required this.price,
    this.titleStyle,
    this.priceStyle,
  });

  final String title, price;
  TextStyle? titleStyle, priceStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style:
              titleStyle ??
              AppStyles.styleRegular16(
                context,
              ).copyWith(color: AppColors.inputsPlaceholder(context)),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              price,
              textAlign: TextAlign.start,
              style:
                  priceStyle ??
                  AppStyles.styleMedium15(
                    context,
                  ).copyWith(color: AppColors.typographyHeading(context)),
            ),
            2.horizontalSpace,
            CurrancyLogoWidget(
              color: priceStyle != null
                  ? priceStyle!.color
                  : AppColors.typographyHeading(context),
              maxHeight: 12.h,
              maxWidth: 12.w,
            ),
          ],
        ),
      ],
    );
  }
}

class AddMozaydaWidget extends StatelessWidget {
  const AddMozaydaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      homeCubit.decreaseBid();
                    },
                    child: SvgPicture.asset(
                      AppAssets.app_imagesMinus,
                      height: 70.h,
                      width: 70.w,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              formatNumber(state.topBid),
                              textAlign: TextAlign.start,
                              style: AppStyles.styleBold18(context)
                                  .copyWith(
                                    color: AppColors.typographyHeading(context),
                                  ),
                            ),
                          ),
                        ),
                        2.horizontalSpace,
                        CurrancyLogoWidget(
                          color: AppColors.typographyHeading(context),
                          maxHeight: 15.h,
                          maxWidth: 15.w,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      homeCubit.increaseBid();
                    },
                    child: SvgPicture.asset(
                      AppAssets.app_imagesAddCircle,
                      height: 70.h,
                      width: 70.w,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              Row(
                children: [
                  CallToActionAddMozaydaWidget(),
                  12.horizontalSpace,
                  AppOutlinedButton(
                    width: 48.w,
                    height: 48.h,
                    onPressed: () {
                      LogOutFromAuctionSheetBottomSheet(context);
                    },
                    backgroundColor: Color(0xffFFEDEA),
                    text: '',
                    icon: Assets.appImagesLogout,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
