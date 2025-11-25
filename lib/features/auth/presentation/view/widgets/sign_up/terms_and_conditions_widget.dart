import 'package:flutter/material.dart';
import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/media_query_values.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';

class TermsAndConditionsWidget extends StatefulWidget {
  const TermsAndConditionsWidget({super.key});

  @override
  State<TermsAndConditionsWidget> createState() =>
      _TermsAndConditionsWidgetState();
}

bool isAgreeTerms = true;

class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
              isAgreeTerms = isChecked;
            });
          },
          checkColor: AppColors.white(context),
          activeColor: AppColors.primary(context),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        GestureDetector(
          onTap: () {
            context.navigateTo(Routes.policyScreen);
          },
          child: Text(
            'الشروط والأحكام',
            style: AppStyles.styleMedium15(context)
                .copyWith(color: AppColors.typographyBody(context)),
          ),
        ),
      ],
    );
  }
}
