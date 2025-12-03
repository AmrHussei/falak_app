import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/features/auth/presentation/view/widgets/login/contact_us_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/coustom_app_bar_widget.dart';

class SalesAgentIntroScreen extends StatelessWidget {
  const SalesAgentIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoustomAppBarWidget(title: 'وكيل بيع'),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.primary(context).withOpacity(0.15),
                        width: 20,
                      ),
                    ),
                  ),
                  child: Text(
                    'كن وكيلاً للبيع',
                    style: AppStyles.styleBold32(context),
                  ),
                ),
              ],
            ),
            24.verticalSpace,
            Text(
              AppStrings.salesAgentIntroText,
              style: AppStyles.styleMedium16(
                context,
              ).copyWith(color: AppColors.typographySubTitle(context)),
            ),
            40.verticalSpace,

            AppPrimaryButton(
              width: double.infinity,
              onPressed: () {
                context.navigateTo(Routes.addSalesAgent);
              },
              text: 'انضم إلينا',
            ),
            Spacer(),
            const ContactUsButtonWidget(),
          ],
        ),
      ),
    );
  }
}
