import 'package:falak/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:falak/features/home/presentation/view/widgets/assets_details/confirm_add_bid_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CallToActionAddMozaydaWidget extends StatelessWidget {
  const CallToActionAddMozaydaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppPrimaryButton(
        height: 48.h,
        onPressed: () {
          confirmAddBidSheetBottomSheet(context);
        },
        text: 'أضف مزايدتك',
      ),
    );
  }
}
