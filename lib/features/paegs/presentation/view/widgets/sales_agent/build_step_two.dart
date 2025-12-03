import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/features/paegs/presentation/view/widgets/sales_agent/bank_names_dropdown_button_form_field_widget.dart';

import '../../../../../../core/utils/images.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../view_model/pages_cubit.dart';

class BuildStepTwoWidget extends StatefulWidget {
  const BuildStepTwoWidget({super.key});

  @override
  State<BuildStepTwoWidget> createState() => _BuildStepTwoWidgetState();
}

class _BuildStepTwoWidgetState extends State<BuildStepTwoWidget> {
  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return Form(
      key: pagesCubit.bankDateFormKey,
      child: Column(
        children: [
          BankNamesDropdownButtonFormFieldWidget(),
          16.verticalSpace,
          TextFormFieldWithTitleWidget(
            controller: pagesCubit.bankAccountNumberController,
            filled: true,
            fillColor: AppColors.white(context),
            title: 'رقم الأيبان',
            hint: 'رقم الأيبان',
            validator: (value) {
              if (value == null) {
                return 'يرجى إدخال رقم الآيبان';
              }
              if (value.isEmpty) {
                return 'يرجى إدخال رقم الآيبان';
              }
              if (value.length != 24) {
                return ' رقم الايبان يجب ان يتكون من 22 رقم';
              }
              return null;
            },
            inputFormatters: [LengthLimitingTextInputFormatter(24)],
            onChanged: (value) {
              if (value != null) {
                if (!value.startsWith("SA")) {
                  pagesCubit.bankAccountNumberController.text = "SA";
                  pagesCubit
                      .bankAccountNumberController
                      .selection = TextSelection.fromPosition(
                    TextPosition(
                      offset:
                          pagesCubit.bankAccountNumberController.text.length,
                    ),
                  );
                }
              }
            },
            keyboardType: TextInputType.number,
          ),
          16.verticalSpace,
          GestureDetector(
            onTap: () {
              pagesCubit.pickbankCertificate().then((val) {
                setState(() {});
              });
            },
            child: TextFormFieldWithTitleWidget(
              title: pagesCubit.bankCertificate == null
                  ? 'إرفاق الشهادة المصرفية'
                  : pagesCubit.bankCertificate!.path.split('/').last,
              hint: 'إرفاق الشهادة المصرفية',
              validator: (value) {
                if (pagesCubit.bankCertificate == null) {
                  return 'يرجى إرفاق الشهادة المصرفية';
                }
                return null;
              },
              filled: true,
              fillColor: AppColors.white(context),
              enabled: false,
              keyboardType: TextInputType.number,
              prefix: SvgPicture.asset(
                AppAssets.app_imagesUploadeFilesIcon,
                height: 32.h,
                width: 32.w,
              ),
            ),
          ),
          344.verticalSpace,
        ],
      ),
    );
  }
}
