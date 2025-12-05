import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/coustom_app_bar_widget.dart';
import 'package:falak/core/widgets/empty_widget.dart';
import 'package:falak/core/widgets/error_app_widget.dart';
import 'package:falak/features/wallet/presentation/view_model/wallet/wallet_cubit.dart';

import '../../../../../app/app.dart';
import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/functions/format_number.dart';
import '../../../../../core/widgets/guest_widget.dart';
import '../../../../../generated/assets.dart';
import '../widgets/add_balance_sheet.dart';
import '../widgets/cards_widgets.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WalletCubit walletCubit = context.read<WalletCubit>();
    _tabController.addListener(() {
      switch (_tabController.index) {
        case 0:
          walletCubit.getUserInvoices();

          break;
        case 1:
          walletCubit.getWithdraw();

          break;
        default:
          walletCubit.getHeldFunds();

          break;
      }
    });
    walletCubit.winner = false;
    walletCubit.loss = false;
    if (!KisGuest) {
      walletCubit.getWallet();
      walletCubit.getUserInvoices();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoustomAppBarWidget(title: 'المحفظة'),
      body: KisGuest == true
          ? GuestWidget()
          : Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntroWalletWidget(),
                  16.verticalSpace,
                  Text(
                    'سجل المعاملات',
                    style: AppStyles.styleMedium16(
                      context,
                    ).copyWith(color: AppColors.typographyHeading(context)),
                  ),
                  16.verticalSpace,
                  CustomTabBar(
                    controller: _tabController,
                    haveWidth: false,
                    tabs: [
                      'شحن المحفظة',
                      'طلبات السحب',
                      'المبالغ المحجوزة في المزادت',
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<WalletCubit, WalletState>(
                      builder: (_, state) {
                        return TabBarView(
                          controller: _tabController,
                          children: [
                            ListItemsWidget(
                              length:
                                  state.getUserInvoicesModel?.data.length ?? 0,
                              refresh: () {
                                context.read<WalletCubit>().getUserInvoices();
                              },
                              errorMessage: state.getUserInvoicesError?.message,
                              isLoading:
                                  state.getUserInvoicesRequestState ==
                                  RequestState.loading,
                              child: (int index) {
                                return InvoiceCardWidget(
                                  model:
                                      state.getUserInvoicesModel!.data[index],
                                );
                              },
                            ),
                            ListItemsWidget(
                              length: state.getWithdrawModel?.data.length ?? 0,
                              refresh: () {
                                context.read<WalletCubit>().getWithdraw();
                              },
                              errorMessage: state.getWithdrawError?.message,
                              isLoading:
                                  state.getWithdrawRequestState ==
                                  RequestState.loading,
                              child: (int index) {
                                return WithdrawCardWidget(
                                  model: state.getWithdrawModel!.data[index],
                                );
                              },
                            ),
                            ListItemsWidget(
                              length: state.getHeldFundsModel?.data.length ?? 0,
                              refresh: () {
                                context.read<WalletCubit>().getHeldFunds();
                              },
                              errorMessage: state.getHeldFundsError?.message,
                              isLoading:
                                  state.getHeldFundsRequestState ==
                                  RequestState.loading,
                              child: (int index) {
                                return HeldFundsCardWidget(
                                  model: state.getHeldFundsModel!.data[index],
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
// create LoadingWalletShimmer
class LoadingWalletShimmer extends StatelessWidget {
  const LoadingWalletShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // make is list view builder
    return ListView.builder(
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 100.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        );
      },
    );
  }
}

class IntroWalletWidget extends StatelessWidget {
  const IntroWalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BalanceWidget(),
            16.verticalSpace,
            PinddingMonyWidget(),
            16.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: AppPrimaryButton(
                    onPressed: () {
                      addBalanceSheetBottomSheet(context);
                    },
                    text: 'شحن رصيد',
                    icon: AppAssets.app_imagesAddButtonMoneyIcon,
                  ),
                ),
                8.horizontalSpace,
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {
                      context.navigateTo(Routes.WithdrawScreen);
                    },
                    text: 'سحب رصيد',
                    icon: AppAssets.app_imagesWithdrawButtonIcon,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListItemsWidget extends StatelessWidget {
  const ListItemsWidget({
    super.key,
    required this.length,
    required this.child,
    required this.isLoading,
    this.errorMessage,
    required this.refresh,
  });

  final int length;
  final Widget Function(int) child;
  final Function refresh;
  final bool isLoading;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return length > 0
        ? ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            itemCount: length,
            itemBuilder: (context, index) {
              return child(index);
            },
          )
        : isLoading
        ? const LoadingWalletShimmer()
        : errorMessage != null
        ? ErrorAppWidget(
            text: errorMessage!,
            onTap: () {
              refresh();
            },
          )
        : const EmptyWidget(title: 'لا يوجد بيانات');
  }
}

class WalletButtonWidget extends StatelessWidget {
  const WalletButtonWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.color,
  });

  final String text, icon;
  final Function() onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 0),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 32, maxWidth: 32),
              child: SvgPicture.asset(icon),
            ),
            SizedBox(width: 12),
            Text(
              text,
              style: AppStyles.styleBold16(
                context,
              ).copyWith(color: AppColors.white(context)),
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.imagesBag, height: 52.h, width: 52.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'الرصيد المتاح',
                style: AppStyles.styleRegular14(
                  context,
                ).copyWith(color: AppColors.titleColor(context)),
              ),
              4.verticalSpace,
              Row(
                children: [
                  Flexible(
                    child: BlocSelector<WalletCubit, WalletState, bool>(
                      selector: (state) => state.showWallet,
                      builder: (_, showWallet) {
                        return BlocSelector<WalletCubit, WalletState, num>(
                          selector: (state) =>
                              state.getWalletModel?.data.balance ?? 0.0,
                          builder: (_, balance) {
                            return FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                showWallet ? balance.toString() : '****',
                                style: AppStyles.styleBold24(context).copyWith(
                                  color: AppColors.thirdColor(context),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SvgPicture.asset(
                    Assets.imagesRiyal,
                    height: 18.h,
                    width: 18.w,
                  ),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            context.read<WalletCubit>().changeShowWallet();
          },
          child: Container(
            alignment: AlignmentGeometry.center,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.gray2Text(context),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.imagesIcon, height: 15.h),
                4.horizontalSpace,
                BlocSelector<WalletCubit, WalletState, bool>(
                  selector: (state) => state.showWallet,
                  builder: (_, showWallet) {
                    return Text(
                      showWallet ? 'إخفاء' : 'اظهار',
                      style: AppStyles.styleRegular14(
                        context,
                      ).copyWith(color: AppColors.black22(context)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PinddingMonyWidget extends StatelessWidget {
  const PinddingMonyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          colors: [Color(0xffEFEFEF), Color(0xffFFFFFF)],
          begin: AlignmentDirectional.centerStart,
          end: AlignmentDirectional.centerEnd,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'المبالغ المحجوزة في المزادت' + '  ',
            style: AppStyles.styleRegular12(
              context,
            ).copyWith(color: AppColors.titleColor(context)),
          ),
          Flexible(
            child: BlocSelector<WalletCubit, WalletState, bool>(
              selector: (state) => state.showWallet,
              builder: (_, showWallet) {
                return BlocSelector<WalletCubit, WalletState, String>(
                  selector: (state) =>
                      formatNumber(state.getWalletModel?.heldFunds ?? 0.0),
                  builder: (_, balance) {
                    return FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        showWallet ? balance : '****',
                        style: AppStyles.styleBold18(
                          context,
                        ).copyWith(color: AppColors.thirdColor(context)),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SvgPicture.asset(Assets.imagesRiyal, height: 18.h, width: 18.w),
        ],
      ),
    );
  }
}
