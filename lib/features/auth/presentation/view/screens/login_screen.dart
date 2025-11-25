import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/widgets/adaptive_layout_widget.dart';

import '../widgets/login/login_mobile_layout_widget.dart';

class LoginScreen extends StatefulHookWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    setSystemIOToWhitBGAndDarkIcons();
    super.initState();
  }

  void setSystemIOToWhitBGAndDarkIcons() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.black(context),
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.black(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = useState(0);
    setSystemIOToWhitBGAndDarkIcons();
    return SafeArea(
      child: Scaffold(
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
      ),
    );
  }
}
