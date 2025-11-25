import 'package:falak/core/extensions/string_sxtensions.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/features/auth/presentation/view/widgets/steps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/utils/media_query_values.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../core/widgets/my_snackbar.dart';
import '../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../view_model/auth/auth_cubit.dart';
import '../widgets/sign_up/terms_and_conditions_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoustomAppBarWidget(
        title: 'إنشاء حساب',
        actions: [
          StepsWidget(currentStep: 0, totalSteps: 3, width: 17.w),
          8.horizontalSpace,
        ],
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => SignUpScreenMobileLayoutWidget(),
        tabletLayout: (context) => Center(
          child: SizedBox(
            height: 1.sw,
            width: 600,
            child: SignUpScreenMobileLayoutWidget(),
          ),
        ),
      ),
    );
  }
}

class SignUpScreenMobileLayoutWidget extends HookWidget {
  const SignUpScreenMobileLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();
    final idText = useState('');
    return Form(
      key: cubit.signUpFormKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 31.5.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWithTitleWidget(
              controller: cubit.signUpNationalIDController,
              title: 'الهوية الوطنة / رقم الاقامة',
              hint: 'ادخل الهوية الوطنة / رقم الاقامة',
              onChanged: (v) {
                if (v != null) {
                  idText.value = v;
                }
              },
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
            TermsAndConditionsWidget(),
            16.verticalSpace,
            SignUpButtonWidget(idText: idText.value),
            32.verticalSpace,
            AppOutlinedButton(
              onPressed: () {
                context.navigateTo(Routes.login);
              },
              text: 'تسجيل الدخول',
              firstText: 'لدي حساب',
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpButtonWidget extends StatelessWidget {
  const SignUpButtonWidget({super.key, required this.idText});

  final String idText;

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.signUpRequestState != current.signUpRequestState,
      listener: (context, state) {
        if (state.signUpRequestState == RequestState.loaded) {
          context.navigateTo(Routes.completeSignUpScreen);
        } else if (state.signUpRequestState == RequestState.error) {
          mySnackBar(
            state.signUpError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AppPrimaryButton(
          isLoading: state.signUpRequestState == RequestState.loading,
          isDisabled: !idText.validateNationalId,
          onPressed: () {
            if (!isAgreeTerms) {
              FloatingSnackBar.show(context, 'يرجي قبول الشروط والاحكام');
              return;
            }
            cubit.signUp();
          },
          text: 'إنشاء حساب جديد',
        );
      },
    );
  }
}
