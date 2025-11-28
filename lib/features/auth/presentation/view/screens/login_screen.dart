import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/widgets/adaptive_layout_widget.dart';

import '../widgets/login/login_mobile_layout_widget.dart';

class LoginScreen extends HookWidget {
  const LoginScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final currentStep = useState(0);
    return Scaffold(
      body: AdaptiveLayout(
        mobileLayout: (context) =>
            LoginMobileLayoutWidget(currentStep: currentStep),
        tabletLayout: (context) => Center(
          child: SizedBox(
            height: 1.sw,
            width: 600,
            child: LoginMobileLayoutWidget(currentStep: currentStep),
          ),
        ),
      ),
    );
  }
}
