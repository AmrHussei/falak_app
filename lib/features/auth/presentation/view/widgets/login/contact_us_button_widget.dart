import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';

class ContactUsButtonWidget extends StatelessWidget {
  const ContactUsButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSecondaryButton(
      onPressed: () {
        context.navigateTo(Routes.contactUsScreen);
      },
      text: 'تواصل معنا',
      icon: AppAssets.app_imagesContactUs,
    );
  }
}
