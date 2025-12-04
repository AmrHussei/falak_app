import 'package:falak/core/extensions/enums_extensions.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/wallet/data/model/wallet_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key, required this.status, required this.type});
final TransactionStatus status;
final WalletType type;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 2.h,
      ),
      decoration: ShapeDecoration(
        color: status.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
          side: BorderSide(
            width: 1.r,
            color: status.borderColor,
          ),
        ),
      ),
      child: Text(
       status.title(type),
        style: AppStyles.styleBold14(
          context,
        ).copyWith(color: status.textColor),
      ),
    );
  }
}
