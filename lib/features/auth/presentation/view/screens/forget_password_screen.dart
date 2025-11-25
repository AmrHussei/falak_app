import 'package:falak/features/auth/presentation/view/widgets/steps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../view_model/auth/auth_cubit.dart';
import '../widgets/reset_and_forget_password/forget_password_button_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoustomAppBarWidget(
        title: 'إعادة تعين كلمة المرور',
        actions: [
          StepsWidget(currentStep: 0, totalSteps: 3, width: 17.w),
          8.horizontalSpace,
        ],
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => ForgetPasswordMobileLayoutWidget(),
        tabletLayout: (context) => Center(
          child: SizedBox(
            height: 1.sw,
            width: 600,
            child: ForgetPasswordMobileLayoutWidget(),
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordMobileLayoutWidget extends StatelessWidget {
  const ForgetPasswordMobileLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return Form(
      key: cubit.forgetPasswordFormKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 31.5.w,vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWithTitleWidget(
              controller: cubit.identityNumberController,
              title: 'رقم الهوية / الاقامة',
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
            16.verticalSpace,
            ForgetPasswordButtonWidget(),
          ],
        ),
      ),
    );
  }
}
