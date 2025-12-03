import 'package:falak/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_images.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../core/functions/format_number.dart';
import '../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../view_model/wallet/wallet_cubit.dart';

Future<void> addBalanceSheetBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,

    // important to allow rounded corners
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: addBalanceSheetBottomSheetBodyWidget(),
      );
    },
  );
}

class addBalanceSheetBottomSheetBodyWidget extends StatefulWidget {
  const addBalanceSheetBottomSheetBodyWidget({super.key});

  @override
  State<addBalanceSheetBottomSheetBodyWidget> createState() =>
      _addBalanceSheetBottomSheetBodyWidgetState();
}

class _addBalanceSheetBottomSheetBodyWidgetState
    extends State<addBalanceSheetBottomSheetBodyWidget>
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
    WalletCubit walletCubit = context.read<WalletCubit>();
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white(context),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 4,
              // bottom: MediaQuery.of(context).viewInsets.bottom +
              // 8, // important to avoid keyboard hiding content
            ),
            child: Form(
              key: walletCubit.addBalanceKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'شحن رصيد',
                        textAlign: TextAlign.start,
                        style: AppStyles.styleSemiBold16(
                          context,
                        ).copyWith(color: AppColors.typographyHeading(context)),
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: SvgPicture.asset(
                            AppAssets.app_imagesCloseSquare,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormFieldWithTitleWidget(
                        controller: walletCubit.balanceController,
                        title: 'مبلغ الشحن',
                        hint: 'مبلغ الشحن',
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value == '0') {
                            return 'برجاء ادخال مبلغ الشحن ';
                          }

                          return null;
                        },
                        onChanged: (value) {
                          walletCubit.balanceController.text = formatNumber(
                            parseFormattedNumber(
                              walletCubit.balanceController.text.trim(),
                            ),
                          ).toString();
                        },
                        keyboardType: TextInputType.number,
                        suffix: Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: 20,
                            start: 8.w,
                          ),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: InkWell(
                              child: SvgPicture.asset(
                                Assets.imagesCurrencyIcon,
                                fit: BoxFit.contain,
                                color: AppColors.typographyHeading(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      AddBalanceButtonWidget(),
                      SizedBox(height: 24),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddBalanceButtonWidget extends StatelessWidget {
  const AddBalanceButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WalletCubit walletCubit = context.read<WalletCubit>();

    return Row(
      children: [
        Expanded(
          child: AppOutlinedButton(
            onPressed: () {
              context.pop();
            },
            text: 'الغاء',
          ),
        ),
        12.horizontalSpace,
        Expanded(
          flex: 3,
          child: BlocConsumer<WalletCubit, WalletState>(
            listenWhen: (previous, current) =>
                previous.addWalletBalanceRequestState !=
                current.addWalletBalanceRequestState,
            listener: (context, state) {
              if (state.addWalletBalanceRequestState == RequestState.loaded) {
                context.pop();
                FloatingSnackBar.show(
                  context,
                  state.addWalletBalanceMsg ?? 'تم',
                  isError: false,
                );
              } else if (state.addWalletBalanceRequestState ==
                  RequestState.error) {
                FloatingSnackBar.show(
                  context,
                  state.addWalletBalanceError?.message ??
                      'هناك شئ ما خطأ حاول مجددا',
                );
              }
            },
            builder: (context, state) {
              return AppPrimaryButton(
                isLoading:
                    state.addWalletBalanceRequestState ==
                    RequestState.loading,
                onPressed: () {
                  walletCubit.addWalletBalance();
                },
                text: 'شحن',
              );
            },
          ),
        ),
      ],
    );
  }
}
