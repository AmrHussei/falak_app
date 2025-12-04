import 'package:falak/core/extensions/enums_extensions.dart';
import 'package:falak/core/services/pdf_service.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/global_bottom_sheet.dart';
import 'package:falak/core/widgets/my_snackbar.dart';
import 'package:falak/features/wallet/data/model/wallet_details_model.dart';
import 'package:falak/features/wallet/presentation/view/widgets/status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../generated/assets.dart';

class WalletBottomSheet extends HookWidget {
  const WalletBottomSheet({super.key, required this.model, required this.type});

  final WalletDetailsModel model;
  final WalletType type;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    return GlobalBottomSheet(
      height: type == WalletType.other ? 390.h : 440.h,
      action: () {
        context.pop();
      },
      title: 'تفاصيل المعاملة',
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xffE7E9E9)),
          color: AppColors.backgroundPrimary(context),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(model.title, style: AppStyles.styleBold16(context)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          model.amount,
                          style: AppStyles.styleBold18(
                            context,
                          ).copyWith(color: AppColors.secondColor(context)),
                        ),
                      ),
                      SvgPicture.asset(Assets.imagesRiyal, height: 15.h),
                    ],
                  ),
                ),
              ],
            ),
            16.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xffE7E9E9)),
                color: AppColors.white(context),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) => SizedBox(
                  height: 35.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        [
                          'تاريخ المعاملة',
                          'وقت المعاملة',
                          'الرقم المرجعي',
                          'حالة الطلب',
                        ][index],
                        style: AppStyles.styleRegular14(
                          context,
                        ).copyWith(color: AppColors.inputsPlaceholder(context)),
                      ),
                      index == 3
                          ? StatusWidget(status: model.status, type: type)
                          : Flexible(
                              child: Text(
                                [
                                  model.transactionDate,
                                  model.transactionTime,
                                  model.refNumber,
                                ][index],
                                style: AppStyles.styleMedium13(context),
                              ),
                            ),
                    ],
                  ),
                ),
                separatorBuilder: (_, index) => Divider(),
                itemCount: type == WalletType.other ? 3 : 4,
              ),
            ),
            8.verticalSpace,
            AppOutlinedButton(
              isLoading: isLoading.value,
              onPressed: () async {
                isLoading.value = true;
                FloatingSnackBar.show(
                  context,
                  'جاري طباعة الفاتورة',
                  isError: false,
                );
                await PdfService.generateAndDownloadInvoice(
                  title: model.title,
                  amount: model.amount,
                  date: model.transactionDate,
                  time: model.transactionTime,
                  referenceNumber: model.refNumber,
                  status: type == WalletType.other ? null : model.status.title(type),
                  context: context,
                );
                isLoading.value = false;
              },
              text: 'تحميل المعاملة',
              icon: Assets.appImagesPdfIcon,
            ),
          ],
        ),
      ),
    );
  }
}
