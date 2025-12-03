import 'package:falak/core/widgets/phone_suffix_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/paegs/presentation/view/widgets/sales_agent/select_tax_status_radio_button.dart';

import '../../../../../../core/utils/images.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../auth/presentation/view/widgets/sign_up/date_picker_widegt.dart';
import '../../../view_model/pages_cubit.dart';

class BuildStepOneWidget extends StatefulWidget {
  const BuildStepOneWidget({super.key});

  @override
  State<BuildStepOneWidget> createState() => _BuildStepOneWidgetState();
}

class _BuildStepOneWidgetState extends State<BuildStepOneWidget> {
  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return Form(
      key: pagesCubit.companyDataFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.white(context),
            controller: pagesCubit.companyNameController,
            title: 'اسم الشركة',
            hint: 'ادخل اسم الشركة ',
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null) {
                return 'يرجى إدخال اسم الشركة';
              }
              if (value.isEmpty) {
                return 'يرجى إدخال اسم الشركة';
              }
              return null;
            },
          ),
          24.verticalSpace,
          Text(
            'معتمد من انفاذ',
            style: AppStyles.styleMedium14(
              context,
            ).copyWith(color: AppColors.veryPrimaryColor(context)),
          ),
          8.verticalSpace,
          SelectNafathApprovedRadioButton(),
          24.verticalSpace,
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.white(context),
            controller: pagesCubit.commercialRegNumberController,
            title: 'رقم السجل التجاري',
            hint: 'رقم السجل التجاري',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null) {
                return 'يرجى إدخال رقم السجل التجاري';
              }
              if (value.isEmpty) {
                return 'يرجى إدخال رقم السجل التجاري';
              }
              if (value.length != 10) {
                return 'رقم السجل التجاري لابد ان يتكون من 10 ارقام';
              }
              return null;
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
          ),
          16.verticalSpace,
          GestureDetector(
            onTap: () {
              pagesCubit.pickCommercialRegisterAttachment().then((val) {
                setState(() {});
              });
            },
            child: TextFormFieldWithTitleWidget(
              filled: true,
              fillColor: AppColors.white(context),
              title: pagesCubit.commercialRegisterAttachment == null
                  ? 'إرفاق السجل التجاري'
                  : pagesCubit.commercialRegisterAttachment!.path
                        .split('/')
                        .last,
              hint: 'إرفاق السجل التجاري',
              validator: (value) {
                if (pagesCubit.commercialRegisterAttachment == null) {
                  return 'يرجى إرفاق السجل التجاري';
                }
                return null;
              },
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
          DatePickerWidegt(
            text: 'تاريخ الانتهاء',
            controller: pagesCubit.commercialRegEndDateController,
          ),

          16.verticalSpace,
          DatePickerWidegt(
            text: 'تاريخ الاصدار',
            controller: pagesCubit.commercialRegStartDateController,
          ),
          16.verticalSpace,
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.white(context),
            controller: pagesCubit.valAuctionsLicenseNumberController,
            title: 'رقم رخصة فال للمزادات',
            hint: 'رقم رخصة فال للمزادات',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null) {
                return 'يرجى إدخال رقم رخصة فال للمزادات';
              }
              if (value.isEmpty) {
                return 'يرجى إدخال رقم رخصة فال للمزادات';
              }
              return null;
            },
          ),
          16.verticalSpace,
          GestureDetector(
            onTap: () {
              pagesCubit.pickvalAttachment().then((val) {
                setState(() {});
              });
            },
            child: TextFormFieldWithTitleWidget(
              filled: true,
              fillColor: AppColors.white(context),
              title: pagesCubit.valAttachment == null
                  ? 'إرفاق رخصة فال'
                  : pagesCubit.valAttachment!.path.split('/').last,
              hint: 'إرفاق رخصة فال',
              validator: (value) {
                if (pagesCubit.valAttachment == null) {
                  return 'يرجى إرفاق رخصة فال للمزادات';
                }
                return null;
              },
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
          Text(
            'خاضع للضريبة',
            style: AppStyles.styleMedium14(
              context,
            ).copyWith(color: AppColors.veryPrimaryColor(context)),
          ),
          8.verticalSpace,
          SelectTaxStatusRadioButton(),
          24.verticalSpace,
          GestureDetector(
            onTap: () {
              pagesCubit.pickAssociationAttachment().then((val) {
                setState(() {});
              });
            },
            child: TextFormFieldWithTitleWidget(
              filled: true,
              fillColor: AppColors.white(context),
              title: pagesCubit.AssociationAttachment == null
                  ? 'إرفاق عقد التأسيس (غير الزامي)'
                  : pagesCubit.AssociationAttachment!.path.split('/').last,
              hint: 'إرفاق عقد التأسيس (غير الزامي)',
              validator: (value) {
                return null;
              },
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
            filled: true,
            fillColor: AppColors.white(context),
            controller: pagesCubit.companyEmailController,
            hint: 'البريد الإلكتروني',
            title: 'البريد الإلكتروني',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null) {
                return 'يرجى إدخال البريد الإلكتروني';
              }
              if (value.isEmpty) {
                return 'يرجى إدخال البريد الإلكتروني';
              }
              return null;
            },
          ),
         16.verticalSpace,
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.white(context),
            controller: pagesCubit.companyPhoneNumberController,
            title: 'رقم الجوال',
            hint: 'رقم الجوال',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يرجى ادخال رقم الجوال';
              }
              if (!RegExp(r'^5\d{8}$').hasMatch(value)) {
                return 'يجب أن يبدأ رقم الجوال ب 5 ويتكون من 9 أرقام';
              }
              return null;
            },
            inputFormatters: [LengthLimitingTextInputFormatter(9)],
            keyboardType: TextInputType.number,
            suffixIconSize: 66.w,
            suffix: const PhoneSuffixWidget(),
          ),
        ],
      ),
    );
  }
}
