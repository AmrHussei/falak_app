import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/widgets/my_snackbar.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_title_and_location_widget.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DownloadWidget extends StatelessWidget {
  const DownloadWidget({
    super.key,
    required this.link,
    this.withBorder = false,
  });

  final String link;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<HomeCubit>().auctionBrochure(context, link);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.white(context),
          border:
              withBorder ? Border.all(color: const Color(0xffE7E9E9)) : null,
        ),
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
        child: Row(
          children: [
            SvgPicture.asset(
              Assets.appImagesPdfIcon,
              width: 19.w,
              height: 19.h,
            ),
            12.horizontalSpace,
            Text(
              'برشور المزاد',
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: AppColors.inputsPlaceholder(context)),
            ),
            Spacer(),
            BlocConsumer<HomeCubit, HomeState>(
              listenWhen:
                  (previous, current) =>
                      previous.auctionBrochureRequestState !=
                      current.auctionBrochureRequestState,
              listener: (context, state) {
                if (state.auctionBrochureRequestState == RequestState.loaded) {
                  FloatingSnackBar.show(
                    context,
                    'تم تحميل البروشور بنجاح',
                    isError: false,
                  );
                } else if (state.auctionBrochureRequestState ==
                    RequestState.error) {
                  mySnackBar(
                    state.auctionBrochureError?.message ??
                        'هناك شئ ما خطأ حاول مجددا',
                    context,
                    isError: true,
                  );
                }
              },
              builder: (context, state) {
                if (state.auctionBrochureRequestState == RequestState.loading) {
                  return CustomCircularProgressIndicatorWidget();
                } else {
                  return InkWell(
                    onTap: () {
                      context.read<HomeCubit>().auctionBrochure(context, link);
                    },
                    child: Card(
                      color: AppColors.white(context),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h,
                        ),
                        child: SvgPicture.asset(
                          Assets.imagesDownload,
                          height: 12.8.h,
                          width: 12.8.w,
                          color: AppColors.secondColor(context),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
