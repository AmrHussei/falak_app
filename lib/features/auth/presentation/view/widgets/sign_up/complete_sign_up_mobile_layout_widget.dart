import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/custom_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/error_app_widget.dart';
import 'package:falak/features/auth/presentation/view/widgets/sign_up/sign_up_password_widget.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../view_model/auth/auth_cubit.dart';

class CompleteSignUpMobileLayoutWidget extends StatefulWidget {
  const CompleteSignUpMobileLayoutWidget({super.key});

  @override
  State<CompleteSignUpMobileLayoutWidget> createState() =>
      _CompleteSignUpMobileLayoutWidgetState();
}

class _CompleteSignUpMobileLayoutWidgetState
    extends State<CompleteSignUpMobileLayoutWidget> {
  @override
  void initState() {
    context.read<AuthCubit>().getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return Form(
      key: cubit.completeSignUpFormKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 31.5.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SignUpPasswordWidget(),
            24.verticalSpace,
            CitiesDropdownButtonFormFieldWidget(),
            32.verticalSpace,
            Divider(
              color: AppColors.disabled(context),
              thickness: 1,
              height: 1,
            ),
            32.verticalSpace,
            TextFormFieldWithTitleWidget(
              title: 'الاسم بالكامل',
              hint: 'ادخل الاسم بالكامل ',
              controller: cubit.completeSignUpNameController,
              enabled: false,
            ),
            24.verticalSpace,
            TextFormFieldWithTitleWidget(
              title: 'الهوية الوطنة / رقم الاقامة',
              hint: 'ادخل الهوية الوطنة / رقم الاقامة',
              controller: cubit.completeSignUpNationalIDController,
              enabled: false,
            ),

            24.verticalSpace,
            TextFormFieldWithTitleWidget(
              controller: cubit.completeSignUpPhoneController,
              title: 'رقم الجوال',
              hint: 'ادخل رقم الجوال',
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
            24.verticalSpace,
            CompleteSignUpButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class CompleteSignUpButtonWidget extends StatelessWidget {
  const CompleteSignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.completeSignUpRequestState !=
          current.completeSignUpRequestState,
      listener: (context, state) {
        if (state.completeSignUpRequestState == RequestState.loaded) {
          context.navigateToWithArguments(Routes.oTPScreen, {
            'nextRoute': Routes.layoutScreen,
            'totalSteps': 3,
            'currentStep': 2,
            'width': 95.0,
          });
          mySnackBar(
            state.completeSignUpMsg ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: false,
          );
        } else if (state.completeSignUpRequestState == RequestState.error) {
          mySnackBar(
            state.completeSignUpError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AppPrimaryButton(
          isLoading: state.completeSignUpRequestState == RequestState.loading,
          onPressed: () {
            cubit.completeSignUp();
          },
          text: 'التالي',
        );
      },
    );
  }
}

class CitiesDropdownButtonFormFieldWidget extends StatefulWidget {
  CitiesDropdownButtonFormFieldWidget({super.key, this.selectedValue});

  final String? selectedValue;

  @override
  State<CitiesDropdownButtonFormFieldWidget> createState() =>
      _DropdownButtonFormFieldWidgetState();
}

class _DropdownButtonFormFieldWidgetState
    extends State<CitiesDropdownButtonFormFieldWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = context.read<AuthCubit>();
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.getCountriesRequestState == RequestState.error) {
          return ErrorAppWidget(
            text: 'جدث شئ ما خطأ',
            onTap: () {
              context.read<AuthCubit>().getCountries();
            },
          );
        } else {
          final countries = state.getCountriesModel?.data ?? [];

          // تحديث القيمة المحددة إذا كانت موجودة في القائمة
          if (selectedValue != null && countries.isNotEmpty) {
            final country = countries.firstWhere(
              (country) => country.name == selectedValue,
              orElse: () => countries.first,
            );
            authCubit.completeSignUpCountryID = country.id;
            profileCubit.editUserInfoCountryID = country.id;
          }

          // إنشاء قائمة فريدة من العناصر
          final uniqueItems = countries
              .map(
                (country) => DropdownMenuItem<String>(
                  value: country.name,
                  onTap: () {
                    authCubit.completeSignUpCountryID = country.id;
                    profileCubit.editUserInfoCountryID = country.id;
                    profileCubit.EditCountryIDFunction();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      country.name,
                      style: AppStyles.styleRegular16(
                        context,
                      ).copyWith(color: AppColors.typographyBody(context)),
                    ),
                  ),
                ),
              )
              .toList();

          // التحقق من وجود القيمة المحددة في القائمة
          if (selectedValue != null &&
              !uniqueItems.any((item) => item.value == selectedValue)) {
            selectedValue = null;
          }

          // إذا كانت القائمة فارغة، نعرض رسالة
          if (countries.isEmpty) {
            return Center(
              child: Text(
                'جاري تحميل المدن...',
                style: AppStyles.styleRegular16(context),
              ),
            );
          }

          return CustomDropdownWidget<String>(
            hint: selectedValue ?? 'حدد المدينة',
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
            validator: (value) {
              if (authCubit.completeSignUpCountryID == null) {
                return 'يرجى اختيار المدينة';
              }
              return null;
            },
            items: uniqueItems,
            title: 'المدينة',
            onClear: () {
              setState(() {
                selectedValue = null;
              });
              authCubit.completeSignUpCountryID = null;
              profileCubit.deleteCountryIDFunction();
              authCubit.getCountries();
            },
            showClearButton: selectedValue != null,
          );
        }
      },
    );
  }
}
