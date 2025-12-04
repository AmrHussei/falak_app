import 'package:falak/features/wallet/data/model/wallet_details_model.dart';
import 'package:falak/features/wallet/presentation/view/widgets/status_widget.dart';
import 'package:falak/features/wallet/presentation/view/widgets/wallet_bottom_sheet.dart'
    show WalletBottomSheet;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_images.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';

class HeldFundsCardWidget extends StatelessWidget {
  const HeldFundsCardWidget({super.key, required this.model});

  final WalletDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isDismissible: false,
          isScrollControlled: true,
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) =>
              WalletBottomSheet(model: model, type: WalletType.other),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(AppAssets.app_imagesHeldFundes, height: 40.h),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                         model.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.styleMedium14(
                            context,
                          ).copyWith(color: AppColors.typographyHeading(context)),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            model.amount,
                            style: AppStyles.styleBold14(context).copyWith(
                              color: AppColors.typographyHeading(context),
                            ),
                          ),
                          SvgPicture.asset(
                            Assets.imagesCurrencyIcon,
                            height: 12.h,
                            color: AppColors.typographyHeading(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  Text(
                    model.transactionDate + ' ${model.transactionTime}',
                    style: AppStyles.styleRegular11(
                      context,
                    ).copyWith(color: AppColors.iconsTertiary(context)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WithdrawCardWidget extends StatelessWidget {
  const WithdrawCardWidget({super.key, required this.model});

  final WalletDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isDismissible: false,
          isScrollControlled: true,
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) =>
              WalletBottomSheet(model: model, type: WalletType.withdraw),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(AppAssets.app_imagesWithdr, height: 40.h),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'سحب رصيد',
                        style: AppStyles.styleMedium14(
                          context,
                        ).copyWith(color: AppColors.typographyHeading(context)),
                      ),
                      Row(
                        children: [
                          Text(
                            model.amount,
                            style: AppStyles.styleBold14(context).copyWith(
                              color: AppColors.typographyHeading(context),
                            ),
                          ),
                          SvgPicture.asset(
                            Assets.imagesCurrencyIcon,
                            height: 12.h,
                            color: AppColors.typographyHeading(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.transactionDate + ' ${model.transactionTime}',
                        style: AppStyles.styleRegular11(
                          context,
                        ).copyWith(color: AppColors.iconsTertiary(context)),
                      ),
                      StatusWidget(
                        status: model.status,
                        type: WalletType.withdraw,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceCardWidget extends StatelessWidget {
  const InvoiceCardWidget({super.key, required this.model});

  final WalletDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isDismissible: false,
          isScrollControlled: true,
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) =>
              WalletBottomSheet(model: model, type: WalletType.charge),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.app_imagesAddmony,
              height: 40.h,
              width: 40.w,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'شحن رصيد',
                        style: AppStyles.styleMedium14(
                          context,
                        ).copyWith(color: AppColors.typographyHeading(context)),
                      ),
                      Row(
                        children: [
                          Text(
                            model.amount,
                            style: AppStyles.styleBold14(context).copyWith(
                              color: AppColors.typographyHeading(context),
                            ),
                          ),
                          SvgPicture.asset(
                            Assets.imagesCurrencyIcon,
                            height: 12.h,
                            color: AppColors.typographyHeading(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                  12.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.transactionDate + ' ${model.transactionTime}',
                        style: AppStyles.styleRegular11(
                          context,
                        ).copyWith(color: AppColors.iconsTertiary(context)),
                      ),
                      StatusWidget(
                        status: model.status,
                        type: WalletType.charge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
