import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/global_bottom_sheet.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/images.dart';
import '../../../../../../core/widgets/my_snackbar.dart';

Future<void> LogOutFromAuctionSheetBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (context) {
      return LogOutFromAuctionSheetBottomSheetBodyWidget();
    },
  );
}

class LogOutFromAuctionSheetBottomSheetBodyWidget extends StatefulWidget {
  const LogOutFromAuctionSheetBottomSheetBodyWidget({super.key});

  @override
  State<LogOutFromAuctionSheetBottomSheetBodyWidget> createState() =>
      _LogOutFromAuctionSheetBottomSheetBodyWidgetState();
}

class _LogOutFromAuctionSheetBottomSheetBodyWidgetState
    extends State<LogOutFromAuctionSheetBottomSheetBodyWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalBottomSheet(
      title: '',
      height: 310.h,
      action: () {
        context.pop();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.appImagesLogout, height: 60.h),
          16.verticalSpace,
          Text(
            'تأكيد المغادرة',
            textAlign: TextAlign.center,
            style: AppStyles.styleBold22(
              context,
            ).copyWith(color: AppColors.typographyHeading(context)),
          ),
          8.verticalSpace,
          Text(
            'هل انت متأكد من انك تريد مغادرة المزاد',
            textAlign: TextAlign.center,
            style: AppStyles.styleSemiBold14(
              context,
            ).copyWith(color: AppColors.typographySubTitle(context)),
          ),
          32.verticalSpace,
          LogOutFromAuctionButtonWidget(),
        ],
      ),
    );
  }
}

class LogOutFromAuctionButtonWidget extends StatelessWidget {
  const LogOutFromAuctionButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Row(
      children: [
        AppOutlinedButton(
          width: 80.w,
          onPressed: () {
            context.pop();
          },
          text: 'الغاء',
        ),
        12.horizontalSpace,
        Expanded(
          child: BlocConsumer<HomeCubit, HomeState>(
            listenWhen: (previous, current) =>
                previous.deleteAuctionEnrollmentRequestState !=
                current.deleteAuctionEnrollmentRequestState,
            listener: (context, state) {
              if (state.deleteAuctionEnrollmentRequestState ==
                  RequestState.loaded) {
                context.pop();
                FloatingSnackBar.show(
                  context,
                  'تم المغادرة من المزاد بنجاح',
                  isError: false,
                );
              } else if (state.deleteAuctionEnrollmentRequestState ==
                  RequestState.error) {
                FloatingSnackBar.show(
                  context,
                  state.deleteAuctionEnrollmentError?.message ??
                      'هناك شئ ما خطأ حاول مجددا',
                );
              }
            },
            builder: (context, state) {
              return AppPrimaryButton(
                isLoading:
                    state.deleteAuctionEnrollmentRequestState ==
                    RequestState.loading,
                onPressed: () {
                  homeCubit.originId = homeCubit.auctionOrigin!.id;
                  homeCubit.auctionId = homeCubit.auctionData!.id;
                  homeCubit.amount = null;
                  homeCubit.deleteAuctionEnrollment();
                },
                text: 'المغادرة',
              );
            },
          ),
        ),
      ],
    );
  }
}
