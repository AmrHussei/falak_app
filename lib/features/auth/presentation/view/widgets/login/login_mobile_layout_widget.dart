import 'package:falak/features/auth/presentation/view/widgets/login/contact_us_button_widget.dart';
import 'package:falak/features/auth/presentation/view/widgets/steps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/auth/presentation/view/widgets/login/login_password_widget.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/app_animations.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../../core/widgets/app_buttons.dart';
import '../../../view_model/auth/auth_cubit.dart';
import '../auth_app_logo_widget.dart';

class LoginMobileLayoutWidget extends StatelessWidget {
  const LoginMobileLayoutWidget({super.key, required this.currentStep});

  final ValueNotifier<int> currentStep;

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return Form(
      key: cubit.loginFormKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 31.5.w, vertical: 8.h),

        child: Column(
          children: [
            AuthAppLogoWidget(),
            32.verticalSpace,
            Text(
              'تسجيل الدخول',
              style: AppStyles.styleBold24(
                context,
              ).copyWith(color: AppColors.typographyHeading(context)),
            ),
            12.verticalSpace,
            StepsWidget(currentStep: currentStep, totalSteps: 2),
            24.verticalSpace,
            TextFormFieldWithTitleWidget(
              controller: cubit.identityNumberController,
              title: 'رقم الهوية/الاقامة',
              hint: 'أدخل رقم الهوية / الاقامة',
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
            12.verticalSpace,
            LoginPasswordWidget(),
            12.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RememberUserWidget(),
                InkWell(
                  onTap: () {
                    context.navigateTo(Routes.forgetPasswordScreen);
                  },
                  child: Text(
                    'نسيت كلمة المرور ؟',
                    style: AppStyles.styleMedium15(context),
                  ),
                ),
              ],
            ),
            12.verticalSpace,
            LoginButtonWidget(),
            24.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: Divider(color: AppColors.separatingBorder1(context)),
                ),
                6.horizontalSpace,
                Text(
                  'او',
                  style: AppStyles.styleBold14(
                    context,
                  ).copyWith(color: AppColors.typographyBody(context)),
                ),
                6.horizontalSpace,
                Expanded(
                  child: Divider(color: AppColors.separatingBorder1(context)),
                ),
              ],
            ),
            24.verticalSpace,
            AppOutlinedButton(
              onPressed: () {
                context.navigateTo(Routes.signUpScreen);
              },
              text: 'إنشاء حساب جديد',
            ),
            140.verticalSpace,
            const ContactUsButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class RememberUserWidget extends StatefulWidget {
  const RememberUserWidget({super.key});

  @override
  State<RememberUserWidget> createState() => _RememberUserWidgetState();
}

class _RememberUserWidgetState extends State<RememberUserWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Row(
        children: [
          Checkbox.adaptive(
            checkColor: AppColors.white(context),
            activeColor: AppColors.primary(context),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
          Text(
            'تذكرني',
            style: AppStyles.styleRegular13(
              context,
            ).copyWith(color: AppColors.titleColor(context)),
          ),
        ],
      ),
    );
  }
}

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.loginRequestState != current.loginRequestState,
      listener: (context, state) {
        if (state.loginRequestState == RequestState.loaded) {
          context.navigateToWithArguments(Routes.oTPScreen, {
            'nextRoute': Routes.layoutScreen,
            'totalSteps': 2,
            'currentStep': 2,
            'width': 123.0,
          });
          mySnackBar(
            state.loginMsg ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: false,
          );
        } else if (state.loginRequestState == RequestState.error) {
          FloatingSnackBar.show(
            context,
            state.loginError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AppPrimaryButton(
          onPressed: () {
            cubit.login();
          },
          text: 'تسجيل الدخول',
          isLoading: state.loginRequestState == RequestState.loading,
          loadingWidget: Lottie.asset(
            AppAnimationAssets.loading,
            width: 32.w,
            height: 32.h,
          ),
        );
      },
    );
  }
}
