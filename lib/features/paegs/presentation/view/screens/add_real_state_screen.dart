import 'package:falak/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../core/utils/enums.dart';
import '../../../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../../../core/widgets/show_success_bottom_sheet.dart';
import '../../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../view_model/pages_cubit.dart';

class AddRealStateScreen extends HookWidget {
  const AddRealStateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isRated = useState(true);
    PagesCubit cubit = context.read<PagesCubit>();
    return Scaffold(
      appBar: CoustomAppBarWidget(title: 'أضف عقارك'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 31.5.w, vertical: 24.h),
        child: Form(
          key: cubit.addRealFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ادخل تفاصيل عقارك', style: AppStyles.styleBold18(context)),
              24.verticalSpace,
              TextFormFieldWithTitleWidget(
                controller: cubit.realStateNameController,
                title: 'الإسم بالكامل',
                hint: 'الإسم بالكامل',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء ادخال الإسم ';
                  }

                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              16.verticalSpace,
              TextFormFieldWithTitleWidget(
                controller: cubit.realStatephoneNumberController,
                title: 'رقم الجوال',
                hint: 'رقم الجوال',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء ادخال رقم الجوال';
                  }
                  if (!RegExp(r'^5\d{8}$').hasMatch(value)) {
                    return 'يجب أن يبدأ رقم الجوال ب 5 ويتكون من 9 أرقام';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                suffixIconSize: 66.w,
                suffix: Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  width: 59.w,
                  margin: EdgeInsetsDirectional.only(end: 6.w, start: 1.w),
                  decoration: BoxDecoration(
                    color: AppColors.containerGrayColor(context),
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  ),
                  child: Text(
                    '966+',
                    style: AppStyles.styleBold14(
                      context,
                    ).copyWith(color: AppColors.veryGrayColor(context)),
                  ),
                ),
              ),
              16.verticalSpace,
              TextFormFieldWithTitleWidget(
                controller: cubit.areaController,
                title: 'المساحة',
                hint: 'المساحة',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء ادخال المساحة';
                  }

                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldWithTitleWidget(
                      controller: cubit.cityController,
                      title: 'المدينة',
                      hint: 'المدينة',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء ادخال المدينة';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: TextFormFieldWithTitleWidget(
                      controller: cubit.neighborhoodController,
                      title: 'الحي',
                      hint: 'الحي',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'برجاء ادخال الحي';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              16.verticalSpace,
              TextFormFieldWithTitleWidget(
                controller: cubit.descriptionController,
                title: 'وصف العقار',
                hint: 'وصف العقار',
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء ادخال وصف العقار';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              16.verticalSpace,
              Text(
                'هل العقار مقيم تقييم معتمد؟',
                style: AppStyles.styleSemiBold16(
                  context,
                ).copyWith(color: AppColors.typographyHeading(context)),
              ),
              8.verticalSpace,

              SelectRealEstateStatusRadioButton(isRated: isRated),
              32.verticalSpace,
              AddRealStateButtonWidget(isRated: isRated.value),
            ],
          ),
        ),
      ),
    );
  }
}

class AddRealStateButtonWidget extends StatelessWidget {
  const AddRealStateButtonWidget({super.key, required this.isRated});

  final bool isRated;

  @override
  Widget build(BuildContext context) {
    PagesCubit cubit = context.read<PagesCubit>();

    return BlocConsumer<PagesCubit, PagesState>(
      listenWhen: (previous, current) =>
          previous.addRealStateRequestState != current.addRealStateRequestState,
      listener: (context, state) {
        if (state.addRealStateRequestState == RequestState.loaded) {
          showSuccessBottomSheet(
            context: context,
            title: 'تم إرسال الطلب بنجاح ',
            subTitle: 'سيتم التواصل معك قريبا جداً.........',
          );
        } else if (state.addRealStateRequestState == RequestState.error) {
          mySnackBar(
            state.addRealStateError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AppPrimaryButton(
          isLoading: state.addRealStateRequestState == RequestState.loading,
          onPressed: () {
            cubit.addRealState(isRated);
          },
          text: 'إرسال',
        );
      },
    );
  }
}

class SelectRealEstateStatusRadioButton extends StatelessWidget {
  const SelectRealEstateStatusRadioButton({super.key, required this.isRated});

  final ValueNotifier<bool> isRated;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            isRated.value = true;
          },
          child: SelectButton(isSelected: isRated.value == true, title: 'نعم'),
        ),
        11.horizontalSpace,
        InkWell(
          onTap: () {
            isRated.value = false;
          },
          child: SelectButton(isSelected: isRated.value == false, title: 'لا'),
        ),
      ],
    );
  }
}

class SelectButton extends StatelessWidget {
  const SelectButton({
    super.key,
    required this.isSelected,
    required this.title,
  });

  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 158.w,
      height: 36.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        border: Border.all(
          color: isSelected
              ? AppColors.secondColor(context)
              : AppColors.veryGrayColor(context),
        ),
        color: isSelected
            ? AppColors.secondColor(context).withValues(alpha: 0.1)
            : Colors.white,
      ),
      child: Text(
        title,
        style: AppStyles.styleMedium12(context).copyWith(
          color: isSelected ? AppColors.secondColor(context) : Colors.black,
        ),
      ),
    );
  }
}
