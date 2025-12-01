import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/features/profile/presentation/view/widgets/agencies/show_add_agencies_bottom_sheet.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';

class AddAgencyButtonWidget extends StatelessWidget {
  const AddAgencyButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      onPressed: () {
        showAddAgenciesBottomSheet(context);
      },
      text: 'اضافة وكالة',
      icon: Assets.appImagesAddAgency,
    );
  }
}
