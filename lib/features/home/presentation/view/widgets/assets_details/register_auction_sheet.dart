import 'package:falak/core/widgets/global_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_strings.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/home/presentation/view/widgets/assets_details/enrollment_buttom_sheet.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';
import 'package:falak/features/home/presentation/view/widgets/mozayda_sheet/mozayda_sheet.dart';

import '../../../../../profile/presentation/view_model/profile/profile_cubit.dart';
import '../../../view_model/home/home_cubit.dart';

Future<void> registerAuctionSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (context) {
      return RegisterAuctionSheetBodyWidget();
    },
  );
}

class RegisterAuctionSheetBodyWidget extends StatefulWidget {
  const RegisterAuctionSheetBodyWidget({super.key});

  @override
  State<RegisterAuctionSheetBodyWidget> createState() =>
      _RegisterAuctionSheetBodyWidgetState();
}

class _RegisterAuctionSheetBodyWidgetState
    extends State<RegisterAuctionSheetBodyWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getAgencies();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalBottomSheet(
      height: 168.h,
      title: 'التسجيل في المزاد',
      action: () {
        context.pop();
      },
      padding: 8.w,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<HomeCubit>().addNewBidValue();
                context.read<HomeCubit>().type = AppStrings.enrolltypeOnline;
                context.pop();

                if (context.read<HomeCubit>().auctionData!.status ==
                    AppStrings.auctionsInProgress) {
                  enrollmentSheetBottomSheet(context);
                } else {
                  mozaydaSheetBottomSheet(context);
                }
              },
              child: Container(
                width: double.infinity,
                height: 56.h,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF9F9F8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      width: 1,
                      color: const Color(0xFF22A06B) /* Color-2 */,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.app_imagesSmartphone),
                    SizedBox(width: 8),
                    Text(
                      'إلكتروني',
                      textAlign: TextAlign.start,
                      style: AppStyles.styleBold18(
                        context,
                      ).copyWith(color: AppColors.typographyHeading(context)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.read<HomeCubit>().addNewBidValue();
                context.read<HomeCubit>().type = AppStrings.enrolltypeOffline;
                context.pop();
                if (context.read<HomeCubit>().auctionData!.status ==
                    AppStrings.auctionsInProgress) {
                  enrollmentSheetBottomSheet(context);
                } else {
                  mozaydaSheetBottomSheet(context);
                }
              },
              child: Container(
                width: double.infinity,
                height: 56.h,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF9F9F8),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: const Color(0xFF22A06B) /* Color-2 */,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.app_imagesUserHandUp),
                    SizedBox(width: 8),
                    Text(
                      'حضوري',
                      textAlign: TextAlign.start,
                      style: AppStyles.styleBold18(
                        context,
                      ).copyWith(color: AppColors.typographyHeading(context)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
