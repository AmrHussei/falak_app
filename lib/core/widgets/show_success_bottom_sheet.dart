import 'package:falak/core/widgets/success_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:falak/core/utils/media_query_values.dart';


Future<void> showSuccessBottomSheet({
  required BuildContext context,
  required String title,
  String? subTitle,
  bool? showHomeButton,
}) async {
  await showModalBottomSheet(
    isDismissible: true,
    isScrollControlled: true,
    enableDrag: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => SuccessBottomSheet(
      title: title,
      subText: subTitle,
      haveButton: showHomeButton ?? false,
      action: () {
        context.pop();
      },
    ),
  );
}
