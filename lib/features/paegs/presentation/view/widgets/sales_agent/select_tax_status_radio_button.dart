import 'package:falak/features/paegs/presentation/view/widgets/contact_us/select_type_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';

import '../../../../../../core/utils/images.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../view_model/pages_cubit.dart';

class SelectTaxStatusRadioButton extends StatefulWidget {
  const SelectTaxStatusRadioButton({super.key});

  @override
  State<SelectTaxStatusRadioButton> createState() =>
      _SelectTaxStatusRadioButtonState();
}

class _SelectTaxStatusRadioButtonState
    extends State<SelectTaxStatusRadioButton> {
  String? _selectedValue = 'خاضع للضريبة';

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
      context.read<PagesCubit>().taxType = _selectedValue!;
      print(_selectedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return Column(
      children: [
        SizedBox(
          height: 40.h,
          child: Row(
            children: [
              RadioItem(
                label: 'خاضع للضريبة',
                value: 'خاضع للضريبة',
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
                context: context,
              ),
              12.horizontalSpace,
              RadioItem(
                label: 'غير خاضع للضريبة',
                value: 'غير خاضع للضريبة',
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
                context: context,
              ),
            ],
          ),
        ),
        _selectedValue == 'خاضع للضريبة'
            ? Column(
                children: [
                  16.verticalSpace,
                  TextFormFieldWithTitleWidget(
                    controller: pagesCubit.taxNumberController,
                    fillColor: AppColors.white(context),
                    filled: true,
                    title: 'الرقم الضريبي',
                    hint: 'الرقم الضريبي',
                    validator: (value) {
                      if (value == null && _selectedValue == 'خاضع للضريبة') {
                        return 'يرجى إدخال الرقم الضريبي';
                      }
                      if (value!.isEmpty && _selectedValue == 'خاضع للضريبة') {
                        return 'يرجى إدخال الرقم الضريبي';
                      }
                      if (_selectedValue == 'خاضع للضريبة') {
                        if (!value.startsWith('3') || value.length != 15) {
                          return 'الرقم الضريبي يجب أن يبدأ بـ ٣ ويتكون من ١٥ رقمًا';
                        }
                      }

                      return null;
                    },
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    keyboardType: TextInputType.number,
                  ),
                  16.verticalSpace,
                  GestureDetector(
                    onTap: () {
                      pagesCubit.pickTaxRegisterAttachment().then((val) {
                        setState(() {});
                      });
                    },
                    child: TextFormFieldWithTitleWidget(
                      title: pagesCubit.TaxRegisterAttachment == null
                          ? 'شهادة التسجيل الضريبي'
                          : pagesCubit.TaxRegisterAttachment!.path
                                .split('/')
                                .last,
                      hint: 'شهادة التسجيل الضريبي',
                      validator: (value) {
                        if (pagesCubit.TaxRegisterAttachment == null &&
                            _selectedValue == 'خاضع للضريبة') {
                          return 'يرجى إرفاق شهادة التسجيل الضريبي';
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
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}

class SelectNafathApprovedRadioButton extends StatefulWidget {
  const SelectNafathApprovedRadioButton({super.key});

  @override
  State<SelectNafathApprovedRadioButton> createState() =>
      _SelectNafathApprovedRadioButtonState();
}

class _SelectNafathApprovedRadioButtonState
    extends State<SelectNafathApprovedRadioButton> {
  String? _selectedValue = 'نعم';
  String? _selectedAccreditationRequestValue = 'نعم';

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
      if (value == 'نعم') {
        context.read<PagesCubit>().approvedByNafath = true;
      } else {
        context.read<PagesCubit>().approvedByNafath = false;
      }
      print(_selectedValue);
    });
  }

  void _handleAccreditationRequestRadioValueChange(String? value) {
    setState(() {
      _selectedAccreditationRequestValue = value;
      if (value == 'نعم') {
        context.read<PagesCubit>().accreditationRequest = true;
      } else {
        context.read<PagesCubit>().accreditationRequest = false;
      }

      print(_selectedAccreditationRequestValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.h,
          child: Row(
            children: [
              RadioItem(
                label: 'نعم',
                value: 'نعم',
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
                context: context,
              ),
              12.horizontalSpace,
              RadioItem(
                label: 'لا',
                value: 'لا',
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
                context: context,
              ),
            ],
          ),
        ),
        _selectedValue == 'لا'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Text(
                    ' هل ترغب بتقديم طلب الاعتماد',
                    style: AppStyles.styleMedium14(
                      context,
                    ).copyWith(color: AppColors.veryPrimaryColor(context)),
                  ),
                  8.verticalSpace,
                  SizedBox(
                    height: 40.h,
                    child: Row(
                      children: [
                        RadioItem(
                          label: 'نعم',
                          value: 'نعم',
                          groupValue: _selectedAccreditationRequestValue,
                          onChanged:
                              _handleAccreditationRequestRadioValueChange,
                          context: context,
                        ),
                        12.horizontalSpace,
                        RadioItem(
                          label: 'لا',
                          value: 'لا',
                          groupValue: _selectedAccreditationRequestValue,
                          onChanged:
                              _handleAccreditationRequestRadioValueChange,
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
