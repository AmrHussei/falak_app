import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../app/app.dart';
import '../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../core/widgets/guest_widget.dart';
import '../widgets/change_password/change_password_button_widget.dart';
import '../widgets/change_password/new_password_widget.dart';
import '../widgets/change_password/old_password_widget.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySurface(context),
      bottomSheet: KisGuest == true
          ? SizedBox.shrink()
          : ChangePasswordButtonWidget(),
      appBar: CoustomAppBarWidget(
        title: 'تغيير كلمه المرور',
      ),
      body: KisGuest == true
          ? GuestWidget()
          : AdaptiveLayout(
              mobileLayout: (context) =>
                  ChangePasswordScreenMobileLayoutWidget(),
              tabletLayout: (context) => Center(
                child: SizedBox(
                  height: 1.sw,
                  width: 600,
                  child: ChangePasswordScreenMobileLayoutWidget(),
                ),
              ),
            ),
    );
  }
}

class ChangePasswordScreenMobileLayoutWidget extends StatelessWidget {
  const ChangePasswordScreenMobileLayoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return Form(
      key: profileCubit.changePasswordeKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 31.5.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' يرجي إدخال كلمة المرور القديمة',
              style: AppStyles.styleBold16(context)
                  .copyWith(color: AppColors.typographyHeading(context)),
            ),
            24.verticalSpace,
            OldPasswordWidget(),
            24.verticalSpace,
            NewPasswordWidget(),
            24.verticalSpace,
            ConfirmNewPasswordWidget(),
          ],
        ),
      ),
    );
  }
}
