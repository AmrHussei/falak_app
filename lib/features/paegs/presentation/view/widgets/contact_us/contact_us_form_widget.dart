import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/phone_suffix_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/features/paegs/presentation/view/widgets/contact_us/select_type_radio_button.dart';
import 'package:falak/features/paegs/presentation/view_model/pages_cubit.dart';

import '../../../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../../core/widgets/show_success_bottom_sheet.dart';

class ContactUsFormWidget extends StatelessWidget {
  const ContactUsFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormFieldWithTitleWidget(
          filled: true,
          fillColor: AppColors.white(context),
          controller: pagesCubit.nameController,
          title: 'الإسم',
          hint: 'الإسم',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'يرجى ادخال الاسم ';
            }
            return null;
          },
          keyboardType: TextInputType.text,
        ),
        16.verticalSpace,
        TextFormFieldWithTitleWidget(
          filled: true,
          fillColor: AppColors.white(context),
          controller: pagesCubit.phoneNumberController,
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
        16.verticalSpace,
        TextFormFieldWithTitleWidget(
          filled: true,
          fillColor: AppColors.white(context),
          controller: pagesCubit.emailController,
          title: 'البريد الإلكتروني',
          hint: 'البريد الإلكتروني',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'يرجى ادخال البريد الالكتروني';
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
        ),
        16.verticalSpace,
        Text(
          'نوع الإستفسار',
          style: AppStyles.styleMedium14(
            context,
          ).copyWith(color: AppColors.veryPrimaryColor(context)),
        ),
        8.verticalSpace,
        SelectTypeRadioButton(),
        16.verticalSpace,
        TextFormFieldWithTitleWidget(
          filled: true,
          fillColor: AppColors.primarySurface(context),
          controller: pagesCubit.messageController,
          title: 'نص الرسالة',
          hint: 'نص الرسالة',
          maxLines: 4,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'يرجى ادخال الرسالة ';
            }
            if (value.length < 10) {
              return 'يجب ان تكون الرساله اكثر من 40 حرف';
            }
            return null;
          },
          keyboardType: TextInputType.text,
        ),
        24.verticalSpace,
        BlocConsumer<PagesCubit, PagesState>(
          listenWhen: (previous, current) =>
              previous.postcontactUsRequestState !=
              current.postcontactUsRequestState,
          listener: (context, state) {
            if (state.postcontactUsRequestState == RequestState.loaded) {
              showSuccessBottomSheet(
                context: context,
                title: '',
                subTitle:
                    'تم إرسال رسالتك بنجاح! شكرًا لتواصلك معنا. سنقوم بمراجعة طلبك والرد عليك قريبًا',
              );
            } else if (state.postcontactUsRequestState == RequestState.error) {
              mySnackBar(
                state.postcontactUsError?.message ??
                    'هناك شئ ما خطأ حاول مجددا',
                context,
                isError: true,
              );
            }
          },
          builder: (context, state) {
            return AppPrimaryButton(
              width: double.infinity,
              onPressed: () {
                context.read<PagesCubit>().postcontactUs();
              },
              text: 'إرسال',
              isLoading:
                  state.postcontactUsRequestState == RequestState.loading,
            );
          },
        ),
      ],
    );
  }
}
