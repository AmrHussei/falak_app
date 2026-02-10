import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/phone_suffix_widget.dart';
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

  Widget _buildWorkStep(BuildContext context, String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: AppColors.primary(context),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: AppStyles.styleBold16(
                context,
              ).copyWith(color: Colors.white),
            ),
          ),
        ),
        12.horizontalSpace,
        Expanded(
          child: Text(
            text,
            style: AppStyles.styleMedium16(context),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ادخل تفاصيل عقارك',
                    style: AppStyles.styleBold18(context),
                  ),

                  ourWorkFlowWidget(context),
                ],
              ),
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
                isPhone: true,

                suffix: const PhoneSuffixWidget(),
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

  InkWell ourWorkFlowWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          builder: (context) => Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppColors.veryGrayColor(context),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                24.verticalSpace,
                Text(
                  'منهجية العمل',
                  style: AppStyles.styleBold20(
                    context,
                  ).copyWith(color: AppColors.typographyHeading(context)),
                ),
                24.verticalSpace,
                _buildWorkStep(
                  context,
                  '1',
                  'أرسل تفاصيل عقارك، وفريق فلك الخير يتأكد من جاهزيته ويتواصل معك مباشرة.',
                ),
                16.verticalSpace,
                _buildWorkStep(
                  context,
                  '2',
                  'نعد لك خطة تسويقية متكاملة ونستوفي كل التراخيص المطلوبة عشان ينطلق المزاد مع فلك الخير.',
                ),
                16.verticalSpace,
                _buildWorkStep(
                  context,
                  '3',
                  'نطلق المزاد ونتابع معك خطوة بخطوة مع فلك الخير لين توصل لأفضل سعر.',
                ),
                24.verticalSpace,
              ],
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.veryPrimaryColor(context).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          'منهجية العمل',
          style: AppStyles.styleBold16(
            context,
          ).copyWith(color: AppColors.veryPrimaryColor(context)),
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
