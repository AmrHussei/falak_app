import 'package:falak/core/utils/images.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/global_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';

Future<void> confirmAddBidSheetBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (context) {
      return confirmAddBidSheetBottomSheetBodyWidget();
    },
  );
}

class confirmAddBidSheetBottomSheetBodyWidget extends StatelessWidget {
  const confirmAddBidSheetBottomSheetBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return GlobalBottomSheet(
      title: 'تأكيد مزايدة',
      height: 250.h,
      action: () {
        context.pop();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'هل انت متأكد من المزايدة بمبلغ',
            textAlign: TextAlign.center,
            style: AppStyles.styleRegular16(
              context,
            ).copyWith(color: AppColors.typographySubTitle(context)),
          ),
          12.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.backgroundPrimary(context),
              border: Border.all(color: Color(0xffe7e9e9)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.app_imagesWalletMoneyenrooleSheet,
                  color: Color(0xFF009951),
                ),
                8.horizontalSpace,
                Text(
                  '${formatNumber(homeCubit.state.total)}',
                  textAlign: TextAlign.start,
                  style: AppStyles.styleRegular16(
                    context,
                  ).copyWith(fontSize: 18, color: Color(0xFF009951)),
                ),
                4.horizontalSpace,

                CurrancyLogoWidget(
                  maxHeight: 15.h,
                  maxWidth: 15.w,
                  color: Color(0xFF009951),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          AddAuctionButtonWidget(),
        ],
      ),
    );
  }
}

class AddAuctionButtonWidget extends StatelessWidget {
  const AddAuctionButtonWidget({super.key});

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
                previous.addAuctionBidRequestState !=
                current.addAuctionBidRequestState,
            listener: (context, state) {
              if (state.addAuctionBidRequestState == RequestState.loaded) {
                context.pop();
                FloatingSnackBar.show(
                  context,
                  state.addAuctionBidMsg ?? 'تم',
                  isError: false,
                );
              } else if (state.addAuctionBidRequestState ==
                  RequestState.error) {
                FloatingSnackBar.show(
                  context,
                  state.addAuctionBidError?.message ??
                      'هناك شئ ما خطأ حاول مجددا',
                );
              }
            },
            builder: (context, state) {
              return AppPrimaryButton(
                isLoading:
                    state.addAuctionBidRequestState == RequestState.loading,
                onPressed: () {
                  if (homeCubit.boardAuctionData.isEmpty) {
                    homeCubit.addAuctionBid();
                    return;
                  }
                  if (homeCubit.state.topBid ==
                      homeCubit.boardAuctionData.first.bidAmount) {
                    FloatingSnackBar.show(
                      context,
                      'يجب ان تقوم بزيادة السعر اولا',
                    );
                    return;
                  } else {
                    homeCubit.addAuctionBid();
                  }
                },
                text: 'تأكيد',
              );
            },
          ),
        ),
      ],
    );
  }
}
