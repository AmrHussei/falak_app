import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/custom_dropdown_widget.dart';
import 'package:falak/core/widgets/global_bottom_sheet.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_details/row_widget.dart';
import 'package:falak/features/paegs/presentation/view/widgets/contact_us/select_type_radio_button.dart';
import 'package:falak/features/wallet/presentation/view_model/wallet/wallet_cubit.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/home/presentation/view/widgets/mozayda_sheet/enrollment_first_widget.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../../app/app.dart';
import '../../../../../../core/functions/format_number.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';
import '../../../../../profile/presentation/view_model/profile/profile_cubit.dart';
import '../../../../../wallet/presentation/view/widgets/add_balance_sheet.dart';

Future<void> enrollmentSheetBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (context) {
      return EnrollmentSheetBottomSheetBodyWidget();
    },
  );
}

class EnrollmentSheetBottomSheetBodyWidget extends StatefulWidget {
  const EnrollmentSheetBottomSheetBodyWidget({super.key});

  @override
  State<EnrollmentSheetBottomSheetBodyWidget> createState() =>
      _EnrollmentSheetBottomSheetBodyWidgetState();
}

class _EnrollmentSheetBottomSheetBodyWidgetState
    extends State<EnrollmentSheetBottomSheetBodyWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().agencyId = null;
    context.read<ProfileCubit>().status = AppStrings.approved;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WalletCubit>().getWallet();
      if (mounted) {
        final profileCubit = context.read<ProfileCubit>();
        if (!profileCubit.isClosed) {
          profileCubit.getAgencies();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (_, state) {
        return GlobalBottomSheet(
          title: 'التسجيل فى المزاد',
          height:
              (state.shareAs == AppStrings.enrollShareAsAgent ? 460.h : 400.h) +
              (KisGuest ? 60.h : 0),
          action: () {
            context.pop();
          },
          color: AppColors.backgroundPrimary(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffE7E9E9)),
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.white(context),
                ),
                child: Text(
                  homeCubit.auctionOrigin!.title ?? '',
                  maxLines: 2,
                  style: AppStyles.styleSemiBold16(
                    context,
                  ).copyWith(color: AppColors.typographyHeading(context)),
                ),
              ),
              12.verticalSpace,
              Text(
                'المشاركة ك',
                textAlign: TextAlign.start,
                style: AppStyles.styleMedium14(
                  context,
                ).copyWith(color: AppColors.typographyHeading(context)),
              ),
              8.verticalSpace,
              SelectSharAsRadioButton(),
              16.verticalSpace,
              RowWidget(
                title: 'عربون الدخول',
                subTitle: formatNumber(
                  homeCubit.auctionOrigin!.entryDeposit,
                ).toString(),
                icon: AppAssets.app_imagesBillCheck,
                subIcon: Assets.imagesRiyal,
              ),
              16.verticalSpace,
              KisGuest ? enrollmentFirstWidget() : EnrollMentCallToAction(),
            ],
          ),
        );
      },
    );
  }
}

class EnrollMentCallToAction extends StatelessWidget {
  const EnrollMentCallToAction({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return Column(
      children: [
        EnrollmentWalletWidget(),
        24.verticalSpace,
        BlocConsumer<HomeCubit, HomeState>(
          listenWhen: (previous, current) =>
              previous.auctionEnrollmentRequestState !=
              current.auctionEnrollmentRequestState,
          listener: (context, state) {
            if (state.auctionEnrollmentRequestState == RequestState.loaded) {
              context.pop();

              FloatingSnackBar.show(
                context,
                state.auctionEnrollmentMsg ?? 'تم',
                isError: false,
              );
            } else if (state.auctionEnrollmentRequestState ==
                RequestState.error) {
              FloatingSnackBar.show(
                context,
                state.auctionEnrollmentError?.message ??
                    'هناك شئ ما خطأ حاول مجددا',
              );
            }
          },
          builder: (context, state) {
            return AppPrimaryButton(
              isLoading:
                  state.auctionEnrollmentRequestState == RequestState.loading,
              onPressed: () {
                if (homeCubit.agencyId == null &&
                    homeCubit.state.shareAs == AppStrings.enrollShareAsAgent) {
                  FloatingSnackBar.show(
                    context,
                    'يجب اختيار وكالة اولا او المشاركة كأصيل',
                  );
                  return;
                } else {
                  homeCubit.type = AppStrings.enrolltypeOnline;
                  homeCubit.originId = homeCubit.auctionOrigin!.id;
                  homeCubit.auctionId = homeCubit.auctionData!.id;
                  homeCubit.auctionEnrollment();
                }
              },
              text: 'تأكيد',
            );
          },
        ),
      ],
    );
  }
}

class EnrollmentWalletWidget extends StatelessWidget {
  const EnrollmentWalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.white(context),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.app_imagesWalletMoneyenrooleSheet,
                    color:
                        ((state.getWalletModel?.data.balance ?? 0) <
                            homeCubit.auctionOrigin!.entryDeposit)
                        ? AppColors.error(context)
                        : Color(0xFF009951),
                  ),
                  6.horizontalSpace,
                  Text(
                    state.getWalletModel?.data.balance.toStringAsFixed(2) ??
                        "0",
                    textAlign: TextAlign.start,
                    style: AppStyles.styleRegular16(context).copyWith(
                      color:
                          ((state.getWalletModel?.data.balance ?? 0) <
                              homeCubit.auctionOrigin!.entryDeposit)
                          ? AppColors.error(context)
                          : Color(0xFF009951),
                    ),
                  ),
                  2.horizontalSpace,

                  CurrancyLogoWidget(
                    maxHeight: 20,
                    maxWidth: 20,
                    color:
                        ((state.getWalletModel?.data.balance ?? 0) <
                            homeCubit.auctionOrigin!.entryDeposit)
                        ? AppColors.error(context)
                        : Color(0xFF009951),
                  ),
                ],
              ),
              if (((state.getWalletModel?.data.balance ?? 0) <
                  homeCubit.auctionOrigin!.entryDeposit))
                AppPrimaryButton(
                  width: 120.w,
                  height: 40.h,
                  onPressed: () {
                    addBalanceSheetBottomSheet(context);
                  },
                  text: 'شحن المحفظة',
                  radius: 5.r,
                  textStyle: AppStyles.styleMedium14(
                    context,
                  ).copyWith(color: AppColors.white(context), fontSize: 13),
                ),
            ],
          ),
        );
      },
    );
  }
}

class SelectSharAsRadioButton extends StatefulWidget {
  const SelectSharAsRadioButton({super.key});

  @override
  State<SelectSharAsRadioButton> createState() =>
      _SelectSharAsRadioButtonState();
}

class _SelectSharAsRadioButtonState extends State<SelectSharAsRadioButton> {
  String? _selectedValue = AppStrings.enrollShareAsGenuine;

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
      context.read<HomeCubit>().changeShareAs(_selectedValue!);
      print(_selectedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            RadioItem(
              label: 'أصيل',
              value: AppStrings.enrollShareAsGenuine,
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChange,
              context: context,
            ),
            8.horizontalSpace,
            RadioItem(
              label: 'وكيل',
              value: AppStrings.enrollShareAsAgent,
              groupValue: _selectedValue,
              onChanged: _handleRadioValueChange,
              context: context,
            ),
          ],
        ),
        SizedBox(
          height: AppStrings.enrollShareAsAgent == _selectedValue ? 8.h : 0,
        ),
        AppStrings.enrollShareAsAgent == _selectedValue
            ? ActiveAgenciesDropdownButtonFormFieldWidget()
            : SizedBox.shrink(),
      ],
    );
  }
}

class ActiveAgenciesDropdownButtonFormFieldWidget extends StatefulWidget {
  const ActiveAgenciesDropdownButtonFormFieldWidget({super.key});

  @override
  State<ActiveAgenciesDropdownButtonFormFieldWidget> createState() =>
      _ActiveAgenciesDropdownButtonFormFieldWidgetState();
}

class _ActiveAgenciesDropdownButtonFormFieldWidgetState
    extends State<ActiveAgenciesDropdownButtonFormFieldWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return CustomDropdownWidget<String>(
          initialValue: selectedValue,
          hint: 'الوكالة',
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          items: profileCubit.agencies.isEmpty
              ? [
                  DropdownMenuItem<String>(
                    value: '',
                    enabled: false,
                    onTap: null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'لا يوجد لديك وكالات مقبولة',
                        style: AppStyles.styleBold16(
                          context,
                        ).copyWith(color: AppColors.typographyHeading(context)),
                      ),
                    ),
                  ),
                ]
              : profileCubit.agencies
                    .map(
                      (agency) => DropdownMenuItem<String>(
                        value: agency.id,
                        onTap: () {
                          homeCubit.agencyId = agency.id;
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            agency.agencyName,
                            style: AppStyles.styleBold16(context).copyWith(
                              color: AppColors.typographyHeading(context),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
        );
      },
    );
  }
}
