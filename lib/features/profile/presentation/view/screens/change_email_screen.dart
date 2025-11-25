import 'package:falak/core/extensions/string_sxtensions.dart';
import 'package:falak/features/auth/presentation/view/widgets/steps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../widgets/change_email/change_email_button_widget.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  @override
  void initState() {
    if (Kemail != null) {
      context.read<ProfileCubit>().emailController.text = Kemail!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoustomAppBarWidget(
        title: 'البريد الالكتروني',
        actions: [
          StepsWidget(currentStep: 1, totalSteps: 3, width: 17.w),
          8.horizontalSpace,
        ],
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => ChangeEmailScreenMobileLayoutWidget(),
        tabletLayout: (context) => Center(
          child: SizedBox(
            height: 1.sw,
            width: 600,
            child: ChangeEmailScreenMobileLayoutWidget(),
          ),
        ),
      ),
    );
  }
}

class ChangeEmailScreenMobileLayoutWidget extends HookWidget {
  const ChangeEmailScreenMobileLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isEmailValid = useState(false);
    ProfileCubit cubit = context.read<ProfileCubit>();
    return Form(
      key: cubit.editEmaileKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 31.5.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWithTitleWidget(
              controller: cubit.emailController,
              onChanged: (value) {
                if (value.isEmailValid) {
                  isEmailValid.value = true;
                } else {
                  isEmailValid.value = false;
                }
              },
              title: 'البريد الالكتروني الجديد',
              hint: 'البريد الالكتروني الجديد',
              validator: (value) {
                if (value == null) {
                  return 'يرجى ادخال البريد الاليكتروني  ';
                }
                if (value.isEmpty) {
                  return 'يرجى ادخال البريد الاليكتروني  ';
                }
                if (!value.contains('@')) {
                  return 'يرجى ادخال  بريد الكتروني صحيح ';
                }

                return null;
              },
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
            ),
            16.verticalSpace,
            ChangeEmailButtonWidget(isEmailValid:isEmailValid.value),
            31.verticalSpace,
          ],
        ),
      ),
    );
  }
}
