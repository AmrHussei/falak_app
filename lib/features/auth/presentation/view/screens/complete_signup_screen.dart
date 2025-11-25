import 'package:falak/features/auth/presentation/view/widgets/steps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../widgets/sign_up/complete_sign_up_mobile_layout_widget.dart';

class CompleteSignUpScreen extends StatefulWidget {
  const CompleteSignUpScreen({super.key});

  @override
  State<CompleteSignUpScreen> createState() => _CompleteSignUpScreenState();
}

class _CompleteSignUpScreenState extends State<CompleteSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoustomAppBarWidget(
        title: 'إنشاء حساب',
        actions: [
          StepsWidget(currentStep: 1, totalSteps: 3, width: 17.w),
          8.horizontalSpace,
        ],
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => CompleteSignUpMobileLayoutWidget(),
        tabletLayout: (context) => Center(
          child: SizedBox(
            height: 1.sw,
            width: 600,
            child: CompleteSignUpMobileLayoutWidget(),
          ),
        ),
      ),
    );
  }
}
