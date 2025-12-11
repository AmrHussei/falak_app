import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/widgets/coustom_app_bar_widget.dart';
import 'package:falak/features/home/presentation/view/screens/mazad_details_screen.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_card_time_widgets.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/images.dart';
import '../../view_model/home/home_cubit.dart';
import '../widgets/assets_details/asset_info_card.dart';
import '../widgets/assets_details/assete_detailes_card_widget.dart';
import '../widgets/assets_details/assets_comming_status_timer_widget.dart';
import '../widgets/assets_details/assets_image_slider.dart';
import '../widgets/assets_details/map_widget.dart';
import '../widgets/assets_details/top_bidders_widget.dart';
import '../widgets/mazad_details/licenses_widget.dart';

class AssetsDetailsScreen extends StatefulWidget {
  const AssetsDetailsScreen({super.key});

  @override
  State<AssetsDetailsScreen> createState() => _AssetsDetailsScreenState();
}

class _AssetsDetailsScreenState extends State<AssetsDetailsScreen> {
  @override
  void initState() {
    HomeCubit homeCubit = context.read<HomeCubit>();
    homeCubit.auctionId = homeCubit.auctionData!.id;
    homeCubit.originId = homeCubit.auctionOrigin!.id;
    homeCubit.amount = null;

    homeCubit.getAuctionBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return Scaffold(
      appBar: CoustomAppBarWidget(
        title: homeCubit.auctionOrigin?.title ?? 'تفاصيل الاصل',
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
          SliverToBoxAdapter(child: AssetsImageSlider()),
          SliverToBoxAdapter(child: 12.verticalSpace),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  AssetsTitleWidget(homeCubit: homeCubit),
                  AssetsDescriptionWidget(),
                  AsseteDetailesCardWidget(),
                  24.verticalSpace,
                  Row(
                    children: [
                      Text(
                        'التفاصيل',
                        style: AppStyles.styleBold24(
                          context,
                        ).copyWith(color: AppColors.typographyHeading(context)),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: homeCubit.auctionOrigin!.details.length,
                    itemBuilder: (context, index) {
                      return AssetsDetailsWidget(index: index);
                    },
                  ),
                  SizedBox(height: 24),
                  MapLocationWidget(),
                  SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: const Color(0xFFD7DBD7),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: RealEstateOrganizationWidget(),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AssetsTitleWidget extends StatelessWidget {
  const AssetsTitleWidget({super.key, required this.homeCubit});

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          homeCubit.auctionData?.title ?? 'المزاد',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          style: AppStyles.styleSemiBold16(context).copyWith(
            color: AppColors.typographyHeading(context),
            height: 1.24,
          ),
        ),
        8.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppAssets.app_imagesLocationDot,
              height: 18.h,
              width: 18.w,
            ),
            4.horizontalSpace,
            Flexible(
              child: Text(
                homeCubit.auctionData?.location?.title ?? 'السعودية',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: AppStyles.styleRegular14(
                  context,
                ).copyWith(color: AppColors.secondColor(context)),
              ),
            ),
          ],
        ),
        8.verticalSpace,

      ],
    );
  }
}
