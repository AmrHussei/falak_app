import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/widgets/phone_suffix_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';

import '../../../../../../core/utils/images.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../auth/presentation/view/widgets/sign_up/date_picker_widegt.dart';
import '../../../view_model/pages_cubit.dart';

class BuildStepThreeWidget extends StatefulWidget {
  const BuildStepThreeWidget({super.key});

  @override
  State<BuildStepThreeWidget> createState() => _BuildStepThreeWidgetState();
}

class _BuildStepThreeWidgetState extends State<BuildStepThreeWidget> {
  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return Form(
      key: pagesCubit.UserDataFormKey,
      child: Column(
        children: [
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.white(context),
            controller: pagesCubit.userNameController,
            title: 'الاسم',
            hint: 'الاسم',
            validator: (value) {
              if (value == null) {
                return ' الاسم مطلوب';
              }
              if (value.isEmpty) {
                return ' الاسم مطلوب';
              }
              return null;
            },
            keyboardType: TextInputType.text,
          ),
          16.verticalSpace,
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.white(context),
            controller: pagesCubit.userIdentityNumberController,
            title: 'الهوية الوطنة / رقم الاقامة',
            hint: 'الهوية الوطنة / رقم الاقامة',
            validator: (value) {
              if (value == null) {
                return 'يرجى إدخال رقم الهوية الوطنية / الاقامة';
              }
              if (value.isEmpty) {
                return 'يرجى إدخال رقم الهوية الوطنية / الاقامة';
              }
              if (value.length != 10) {
                return 'رقم الهوية الوطنية يجب ان يتكون من 10 ارقام';
              }
              if (!value.startsWith('1') && !value.startsWith('2')) {
                return 'رقم الهوية الوطنية / الاقامة خطأ';
              }
              return null;
            },
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
            keyboardType: TextInputType.number,
          ),
          16.verticalSpace,
          DatePickerWidegt(
            text: 'تاريخ الميلاد',
            controller: pagesCubit.userBirthDayController,
          ),
          16.verticalSpace,
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.white(context),
            controller: pagesCubit.userEmailController,
            title: 'البريد الالكتروني',
            hint: 'البريد الالكتروني',
            validator: (value) {
              if (value == null) {
                return ' البريد الالكتروني مطلوب';
              }
              if (value.isEmpty) {
                return ' البريد الالكتروني مطلوب';
              }
              return null;
            },
            keyboardType: TextInputType.text,
          ),
          16.verticalSpace,
          TextFormFieldWithTitleWidget(
            filled: true,
            fillColor: AppColors.white(context),
            controller: pagesCubit.userPhoneNumberController,
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
            suffixIconSize: 66.w,              isPhone: true,

            suffix: const PhoneSuffixWidget(),
          ),
          16.verticalSpace,
          GestureDetector(
            onTap: () {
              pagesCubit.pickNationalIDAttachment().then((val) {
                setState(() {});
              });
            },
            child: TextFormFieldWithTitleWidget(
              title: pagesCubit.NationalIDAttachment == null
                  ? 'إرفاق هوية المفوض'
                  : pagesCubit.NationalIDAttachment!.path.split('/').last,
              hint: 'إرفاق هوية المفوض',
              validator: (value) {
                if (pagesCubit.NationalIDAttachment == null) {
                  return ' إرفاق الهوية مطلوب';
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
          16.verticalSpace,
          GestureDetector(
            onTap: () {
              pagesCubit.pickDelegationAttachment().then((val) {
                setState(() {});
              });
            },
            child: TextFormFieldWithTitleWidget(
              title: pagesCubit.DelegationAttachment == null
                  ? 'إرفاق خطاب التفويض'
                  : pagesCubit.DelegationAttachment!.path.split('/').last,
              hint: 'إرفاق خطاب التفويض',
              validator: (value) {
                if (pagesCubit.DelegationAttachment == null) {
                  return ' إرفاق الخطاب مطلوب';
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
          16.verticalSpace,
          Text(
            '''تتحمّل الشركة كل المسؤولية القانونية أمام الجهات المختصّة عن العقارات المضافة أو اللي راح يتم إضافتها في المنصّة.
الشركة ملتزمة بعد بدفع أي جزاءات أو غرامات تتعلق بأي عقار يتم إدخاله في المنصّة.
يجب ان تكون كل البيانات المُدخلة صحيحة ودقيقة، والمنصة غير مسؤولة عن أي بيانات خاطئة يدخلها الطرف الثاني (وكيل البيع أو الجهة المضافة).
في حال كان وكيل البيع خاضع للضريبة، فهو يتحمّل كامل الغرامات أو الالتزامات المتعلقة بذلك.
يحق للمنصة التعديل علي بيانات المزاد اذا لزم ذالك بالاتفاق مع وكيل البيع''',
            style: AppStyles.styleRegular14(
              context,
            ).copyWith(color: AppColors.grayText(context)),
          ),
          8.verticalSpace,
          Row(
            children: [
              Checkbox(
                value: pagesCubit.isTermsAccepted,
                onChanged: (value) {
                  setState(() {
                    pagesCubit.isTermsAccepted = value ?? false;
                  });
                },
                activeColor: AppColors.secondColor(context),
                side: BorderSide(color: AppColors.textFieldBorder(context)),
              ),
              Expanded(
                child: Text(
                  'موافق على الشروط والاحكام',
                  style: AppStyles.styleRegular13(
                    context,
                  ).copyWith(color: AppColors.secondColor(context)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
