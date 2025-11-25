import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/features/auth/presentation/view/widgets/steps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/utils/media_query_values.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../core/widgets/my_snackbar.dart';
import '../../view_model/auth/auth_cubit.dart';
import '../widgets/reset_and_forget_password/reset_password_widget.dart';

class ResetePasswordScreen extends StatelessWidget {
  const ResetePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoustomAppBarWidget(
        title: 'إعادة تعين كلمة المرور',
        actions: [
          StepsWidget(currentStep: 2, totalSteps: 3, width: 17.w),
          8.horizontalSpace,
        ],
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => ResetePasswordScreenMobileLayoutWidget(),
        tabletLayout: (context) => Center(
          child: SizedBox(
            height: 1.sw,
            width: 600,
            child: ResetePasswordScreenMobileLayoutWidget(),
          ),
        ),
      ),
    );
  }
}

class ResetePasswordScreenMobileLayoutWidget extends StatelessWidget {
  const ResetePasswordScreenMobileLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return Form(
      key: cubit.resetPasswordFormKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 31.5.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ResetPasswordWidget(),
            24.verticalSpace,
            ResetConfirmPasswordWidget(),
            24.verticalSpace,
            ResetPasswordButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordButtonWidget extends StatelessWidget {
  const ResetPasswordButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.resetPasswordRequestState !=
          current.resetPasswordRequestState,
      listener: (context, state) {
        if (state.resetPasswordRequestState == RequestState.loaded) {
          context.navigateToWithReplacementAndClearStack(Routes.layoutScreen);
          mySnackBar(
            'تم إعادة تعين كلمة المرور بنجاح',
            context,
            isError: false,
          );
        } else if (state.resetPasswordRequestState == RequestState.error) {
          mySnackBar(
            state.resetPasswordError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AppPrimaryButton(
          isLoading: state.resetPasswordRequestState == RequestState.loading,
          onPressed: () {
            cubit.resetPassword();
          },
          text: 'تأكيد',
        );
      },
    );
  }
}
