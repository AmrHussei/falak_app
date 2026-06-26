import 'dart:io';

import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/phone_suffix_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../../core/utils/app_strings.dart';
import '../../../../../../../core/utils/enums.dart';
import '../../../../../../../core/utils/images.dart';
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
    final capacity = useState(AppStrings.realEstateCapacityOwner);
    final fileRebuild = useState(0);
    PagesCubit cubit = context.read<PagesCubit>();
    final _ = fileRebuild.value;
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
              TextFormFieldWithTitleWidget(
                controller: cubit.deedNumberController,
                title: 'رقم الصك',
                hint: 'رقم الصك',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'برجاء ادخال رقم الصك';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
              ),
              16.verticalSpace,
              Text(
                'الصفة',
                style: AppStyles.styleSemiBold16(
                  context,
                ).copyWith(color: AppColors.typographyHeading(context)),
              ),
              8.verticalSpace,
              SelectRealEstateCapacityRadioButton(
                capacity: capacity,
                onChanged: (value) {
                  cubit.changeRealEstateCapacity(value);
                },
              ),
              16.verticalSpace,
              RealEstateFilePickerField(
                title: 'تقييم العقار',
                hint: 'ملف التقييم للعقار',
                file: cubit.propertyEvaluation,
                onTap: () {
                  cubit.pickPropertyEvaluation().then((_) {
                    fileRebuild.value++;
                  });
                },
                validator: () {
                  if (cubit.propertyEvaluation == null) {
                    return 'يرجى إرفاق ملف التقييم للعقار';
                  }
                  return null;
                },
              ),
              16.verticalSpace,
              RealEstateFilePickerField(
                title: 'صك العقار',
                hint: 'ملف الصك',
                file: cubit.propertyDeed,
                onTap: () {
                  cubit.pickPropertyDeed().then((_) {
                    fileRebuild.value++;
                  });
                },
                validator: () {
                  if (cubit.propertyDeed == null) {
                    return 'يرجى إرفاق ملف الصك';
                  }
                  return null;
                },
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
                  'نعد لك خطة تسويقية متكاملة حتي ينطلق المزاد مع فلك الخير.',
                ),
                16.verticalSpace,
                _buildWorkStep(
                  context,
                  '3',
                  'نطلق المزاد ونتابع معك خطوة بخطوة حتي أفضل سعر.',
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
    return ValueListenableBuilder<bool>(
      valueListenable: isRated,
      builder: (context, value, _) {
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  isRated.value = true;
                },
                child: SelectButton(
                  isSelected: value,
                  title: 'نعم',
                  expand: true,
                ),
              ),
            ),
            11.horizontalSpace,
            Expanded(
              child: InkWell(
                onTap: () {
                  isRated.value = false;
                },
                child: SelectButton(
                  isSelected: !value,
                  title: 'لا',
                  expand: true,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class SelectRealEstateCapacityRadioButton extends StatelessWidget {
  const SelectRealEstateCapacityRadioButton({
    super.key,
    required this.capacity,
    required this.onChanged,
  });

  final ValueNotifier<String> capacity;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: capacity,
      builder: (context, value, _) {
        return Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  capacity.value = AppStrings.realEstateCapacityOwner;
                  onChanged(AppStrings.realEstateCapacityOwner);
                },
                child: SelectButton(
                  isSelected: value == AppStrings.realEstateCapacityOwner,
                  title: 'مالك',
                  expand: true,
                ),
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: InkWell(
                onTap: () {
                  capacity.value = AppStrings.realEstateCapacityAgent;
                  onChanged(AppStrings.realEstateCapacityAgent);
                },
                child: SelectButton(
                  isSelected: value == AppStrings.realEstateCapacityAgent,
                  title: 'وكيل',
                  expand: true,
                ),
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: InkWell(
                onTap: () {
                  capacity.value = AppStrings.realEstateCapacityBroker;
                  onChanged(AppStrings.realEstateCapacityBroker);
                },
                child: SelectButton(
                  isSelected: value == AppStrings.realEstateCapacityBroker,
                  title: 'وسيط عقاري',
                  expand: true,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class RealEstateFilePickerField extends StatelessWidget {
  const RealEstateFilePickerField({
    super.key,
    required this.title,
    required this.hint,
    required this.file,
    required this.onTap,
    required this.validator,
  });

  final String title;
  final String hint;
  final File? file;
  final VoidCallback onTap;
  final String? Function() validator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormFieldWithTitleWidget(
        title: file == null ? title : file!.path.split('/').last,
        hint: hint,
        validator: (_) => validator(),
        filled: true,
        fillColor: AppColors.white(context),
        enabled: false,
        keyboardType: TextInputType.text,
        prefix: SvgPicture.asset(
          AppAssets.app_imagesUploadeFilesIcon,
          height: 32.h,
          width: 32.w,
        ),
      ),
    );
  }
}

class SelectButton extends StatelessWidget {
  const SelectButton({
    super.key,
    required this.isSelected,
    required this.title,
    this.expand = false,
  });

  final bool isSelected;
  final String title;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: expand ? double.infinity : 158.w,
      height: 36.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
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
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.styleMedium12(context).copyWith(
          color: isSelected ? AppColors.secondColor(context) : Colors.black,
        ),
      ),
    );
  }
}
