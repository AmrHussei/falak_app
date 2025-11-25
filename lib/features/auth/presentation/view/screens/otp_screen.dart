import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/features/auth/presentation/view/widgets/steps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/auth/presentation/view/widgets/timer_widget.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../core/widgets/my_snackbar.dart';
import '../../../../paegs/presentation/view/widgets/sales_agent/stepper_widget.dart';
import '../../view_model/auth/auth_cubit.dart';
import '../widgets/otp/pin_code_widget.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({
    super.key,
    required this.nextRoute,
    required this.currentStep,
    required this.totalSteps,
    required this.width,
    this.title,
  });

  final String nextRoute;
  final String? title;
  final int currentStep;
  final int totalSteps;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CoustomAppBarWidget(
          title: 'أدخل رمز التحقق',
          actions: [
            StepsWidget(
              currentStep: currentStep,
              totalSteps: totalSteps,
              width: 17.w,
            ),
            8.horizontalSpace,
          ],
        ),
        body: AdaptiveLayout(
          mobileLayout: (context) => OTPScreenMobileLayoutWidget(
            nextRoute: nextRoute,
            currentStep: currentStep,
            totalSteps: totalSteps,
            width: width,
            title: title,
          ),
          tabletLayout: (context) => Center(
            child: SizedBox(
              height: 1.sw,
              width: 600,
              child: OTPScreenMobileLayoutWidget(
                nextRoute: nextRoute,
                currentStep: currentStep,
                totalSteps: totalSteps,
                width: width,
                title: title,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OTPScreenMobileLayoutWidget extends HookWidget {
  const OTPScreenMobileLayoutWidget({
    super.key,
    required this.nextRoute,
    required this.currentStep,
    required this.totalSteps,
    required this.width,
    this.title,
  });

  final String nextRoute;
  final int currentStep;
  final int totalSteps;
  final double width;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final otpLength = useState<int>(0);
    final pinCodeKey = useMemoized(() => GlobalKey(), []);

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 31.5.w, vertical: 32.h),
            child: Column(
              children: [
                Text(
                  title ??
                      'فضلا ادخل الرمز المكون من 6 ارقام المرسل لك عبر رساله\n نصية',
                  textAlign: TextAlign.center,
                  style: AppStyles.styleSemiBold14(
                    context,
                  ).copyWith(color: AppColors.typographyBody(context)),
                ),
                24.verticalSpace,
                PinCodeWidget(
                  key: pinCodeKey,
                  onChanged: (code) {
                    otpLength.value = code.length;
                  },
                ),

                24.verticalSpace,
                VerifyButtonWidget(
                  nextRoute: nextRoute,
                  isCodeComplete: otpLength.value >= 6,
                ),
                24.verticalSpace,
                TimerWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPStepperWidget extends StatelessWidget {
  const OTPStepperWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: StepperWidget(
        stepperList: List.generate(totalSteps * 2 - 1, (index) {
          if (index.isEven) {
            // BuildStep
            final stepNum = (index ~/ 2) + 1;
            return BuildStep(
              title: '',
              isActive: stepNum <= currentStep,
              isCompleted: stepNum < currentStep,
              stepNum: stepNum.toString(),
            );
          } else {
            // SteperLineWidegt
            return SteperLineWidegt(isActive: (index ~/ 2) + 1 < currentStep);
          }
        }),
      ),
    );
  }
}

class VerifyButtonWidget extends StatelessWidget {
  const VerifyButtonWidget({
    super.key,
    required this.nextRoute,
    required this.isCodeComplete,
  });

  final String nextRoute;
  final bool isCodeComplete;

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.verifyRequestState != current.verifyRequestState,
      listener: (context, state) {
        if (state.verifyRequestState == RequestState.loaded) {
          if (nextRoute == Routes.userInfoScreen) {
            context.navigateToWithReplacementNamed(nextRoute);
          } else if (nextRoute == Routes.layoutScreen) {
            FloatingSnackBar.show(
              context,
              'مرحبا بكم بمنصة وثيق',
              isError: false,
            );
            context.navigateToWithReplacementAndClearStack(nextRoute);
          } else if (nextRoute == Routes.resetPasswordScreen ||
              nextRoute == Routes.changeEmailScreen ||
              nextRoute == Routes.changePhoneNumberScreen) {
            context.navigateTo(nextRoute);
          } else {
            context.navigateToWithReplacementAndClearStack(nextRoute);
          }
        } else if (state.verifyRequestState == RequestState.error) {
          mySnackBar(
            state.verifyError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AppPrimaryButton(
          isDisabled: !isCodeComplete,
          isLoading: state.verifyRequestState == RequestState.loading,
          onPressed: () {
            cubit.verifyOtp();
          },
          text: 'التحقق',
        );
      },
    );
  }
}
