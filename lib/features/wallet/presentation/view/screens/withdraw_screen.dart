import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/coustom_app_bar_widget.dart';
import 'package:falak/core/widgets/phone_suffix_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../../core/widgets/show_success_bottom_sheet.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../core/functions/format_number.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../auth/presentation/view/widgets/auth_app_logo_widget.dart';
import '../../../../paegs/presentation/view/widgets/sales_agent/bank_names_dropdown_button_form_field_widget.dart';
import '../../view_model/wallet/wallet_cubit.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  String? selectedBank;
  final List<String> bankOptions = [
    'البنك الأهلي السعودي',
    'مصرف الراجحي',
    'بنك الرياض',
    'البنك السعودي الفرنسي',
    'البنك العربي الوطني',
    'بنك البلاد',
    'بنك الجزيرة',
    'البنك السعودي للاستثمار',
    'البنك السعودي الأول (ساب)',
    'مصرف الإنماء',
    'بنك الخليج الدولي - السعودية',
    'بنك إس تي سي (STC Bank)',
    'البنك السعودي الرقمي',
    'بنك دال ثلاث مئة وستون (D360 Bank)',
  ];

  @override
  Widget build(BuildContext context) {
    WalletCubit walletCubit = context.read<WalletCubit>();
    return Scaffold(
      appBar: CoustomAppBarWidget(title: 'سحب رصيد'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

        child: Form(
          key: walletCubit.withdrawFormKey,
          child: Column(
            children: [
              TextFormFieldWithTitleWidget(
                fillColor: Colors.white,
                filled: true,
                controller: walletCubit.beneficiaryNameController,
                title: 'إسم المستفيد',
                hint: 'إسم المستفيد',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'إسم المستفيد مطلوب';
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              TextFormFieldWithTitleWidget(
                fillColor: Colors.white,
                filled: true,
                controller: walletCubit.contactNumberController,
                title: 'رقم التواصل',
                hint: 'رقم التواصل',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'رقم التواصل مطلوب';
                  }
                  if (value.length != 9) {
                    return 'رقم التواصل غير صحيح';
                  }
                  return null;
                },
                suffixIconSize: 66.w,
                isPhone: true,

                suffix: const PhoneSuffixWidget(),
              ),
              16.verticalSpace,
              BankNamesDropdownButtonFormFieldWidget(filled: false),
              16.verticalSpace,
              TextFormFieldWithTitleWidget(
                fillColor: Colors.white,
                filled: true,
                controller: walletCubit.ibanNumberController,
                title: 'رقم الأيبان',
                hint: 'رقم الأيبان',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null) {
                    return ' رقم الايبان مطلوب';
                  }
                  if (value.isEmpty) {
                    return ' رقم الايبان مطلوب';
                  }
                  if (value.length != 24) {
                    return ' رقم الايبان يجب ان يتكون من 22 رقم';
                  }
                  return null;
                },
                inputFormatters: [LengthLimitingTextInputFormatter(24)],
                onChanged: (value) {
                  if (value != null && !value.startsWith('SA')) {
                    walletCubit.ibanNumberController.text = 'SA';
                    walletCubit
                        .ibanNumberController
                        .selection = TextSelection.fromPosition(
                      TextPosition(
                        offset: walletCubit.ibanNumberController.text.length,
                      ),
                    );
                  }
                },
              ),
              16.verticalSpace,
              GestureDetector(
                onTap: () {
                  walletCubit.pickIbanAttachment().then((val) {
                    setState(() {});
                  });
                },
                child: TextFormFieldWithTitleWidget(
                  fillColor: Colors.white,
                  filled: true,
                  title: walletCubit.ibanAttachment == null
                      ? 'شهادة الايبان (إختياري )'
                      : walletCubit.ibanAttachment!.path.split('/').last,
                  hint: 'شهادة الايبان (إختياري )',
                  enabled: false,
                  keyboardType: TextInputType.number,
                  prefix: SvgPicture.asset(
                    AppAssets.app_imagesUploadeFilesIcon,
                    height: 32.h,
                    width: 32.w,
                  ),
                ),
              ),
              16.verticalSpace,
              TextFormFieldWithTitleWidget(
                fillColor: Colors.white,
                filled: true,
                controller: walletCubit.withdrawAmountController,
                title: 'مبلغ السحب ',
                hint: 'مبلغ السحب ',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  walletCubit.withdrawAmountController.text = formatNumber(
                    parseFormattedNumber(
                      walletCubit.withdrawAmountController.text.trim(),
                    ),
                  ).toString();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'مبلغ السحب مطلوب';
                  }

                  if (parseFormattedNumber(value) <= 0) {
                    return 'مبلغ السحب يجب أن يكون أكبر من صفر';
                  }
                  return null;
                },
                suffix: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 18.w,
                  ),
                  child: CurrancyLogoWidget(
                    color: AppColors.typographyHeading(context),
                  ),
                ),
              ),
              16.verticalSpace,
              Text(
                'تتم عملية السحب في خلال 24 ساعة بعد تقديم الطلب',
                style: AppStyles.styleSemiBold16(
                  context,
                ).copyWith(color: AppColors.primary(context)),
              ),
              70.verticalSpace,
              SubmitWithdrawButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class SubmitWithdrawButtonWidget extends StatelessWidget {
  const SubmitWithdrawButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WalletCubit walletCubit = context.read<WalletCubit>();

    return BlocConsumer<WalletCubit, WalletState>(
      listenWhen: (previous, current) =>
          previous.submitWithdrawRequestState !=
          current.submitWithdrawRequestState,
      listener: (context, state) {
        if (state.submitWithdrawRequestState == RequestState.loaded) {
          context.pop();
          showSuccessBottomSheet(
            context: context,
            title: 'تم إرسال طلب السحب ',
            subTitle: 'سيتم التواصل معك قريبا .........',
            showHomeButton: false,
          );
        } else if (state.submitWithdrawRequestState == RequestState.error) {
          mySnackBar(
            state.submitWithdrawError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AppPrimaryButton(
          width: double.infinity,
          isLoading: state.submitWithdrawRequestState == RequestState.loading,
          onPressed: () {
            if (walletCubit.withdrawFormKey.currentState?.validate() == true) {
              walletCubit.submitWithdrawRequest();
            }
          },
          text: 'إرسال طلب السحب',
        );
      },
    );
  }
}
