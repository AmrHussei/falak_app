import 'package:cached_network_image/cached_network_image.dart';
import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserDrawerWidget extends StatelessWidget {
  const UserDrawerWidget({super.key, required this.toggleDrawer});

  final Function() toggleDrawer;

  @override
  Widget build(BuildContext context) {
    final user = context.read<ProfileCubit>().state.profileModel;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: user?.data.profileImage ?? '',
                    height: 40.h,
                    width: 40.h,
                    placeholder: (_, _) =>
                        Image.asset(AppAssets.app_imagesUserCircle),
                    errorWidget: (_, _, _) =>
                        Image.asset(AppAssets.app_imagesUserCircle),
                  ),
                ),
                4.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        user?.data.name ?? 'مرحبا بك',
                        style: AppStyles.styleMedium14(context),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(Assets.imagesBag),
                          Flexible(
                            child: Text(
                              (user?.data.successAuctionsCount ?? 0).toString(),
                              style: AppStyles.styleBold14(
                                context,
                              ).copyWith(color: AppColors.thirdColor(context)),
                            ),
                          ),
                          SvgPicture.asset(Assets.imagesRiyal),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          8.verticalSpace,
          SizedBox(
            height: 40.h,
            child: Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    radius: 12.r,
                    onPressed: () {
                      toggleDrawer();
                      context.navigateTo(Routes.addSalesAgent);
                    },
                    text: 'أضف عقارك',
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
