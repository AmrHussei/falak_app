import 'package:falak/core/widgets/custom_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';

import '../../../../../wallet/presentation/view_model/wallet/wallet_cubit.dart';
import '../../../view_model/pages_cubit.dart';

class BankNamesDropdownButtonFormFieldWidget extends StatefulWidget {
  const BankNamesDropdownButtonFormFieldWidget({super.key, this.filled});

  final bool? filled;

  @override
  State<BankNamesDropdownButtonFormFieldWidget> createState() =>
      _BankNamesDropdownButtonFormFieldWidgetState();
}

class _BankNamesDropdownButtonFormFieldWidgetState
    extends State<BankNamesDropdownButtonFormFieldWidget> {
  String? selectedValue;
  final List<String> options = [
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
    PagesCubit pagesCubit = context.read<PagesCubit>();
    WalletCubit walletCubit = context.read<WalletCubit>();

    return CustomDropdownWidget(
      items: options
          .map(
            (option) => DropdownMenuItem<String>(
              value: option,
              onTap: () {
                pagesCubit.bankNameController.text = option;
                walletCubit.bankNameController.text = option;
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Text(
                  option,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.styleBold12(
                    context,
                  ).copyWith(color: AppColors.typographyHeading(context)),
                ),
              ),
            ),
          )
          .toList(),
      initialValue: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      validator: (value) {
        if (pagesCubit.bankNameController.text.isEmpty) {
          return 'يرجي اختيار اسم البنك';
        }
        return null;
      },
      showClearButton: selectedValue != null,
      onClear: () {
        setState(() {
          selectedValue = null;
        });
        pagesCubit.bankNameController.clear();
        walletCubit.bankNameController.clear();
      },
      title: 'إسم البنك',
      hint: 'حدد الاسم',
    );
  }
}
