import 'package:falak/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/images.dart';

import '../../../../../../core/functions/url_luncher.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/mazad_title_and_location_widget.dart';

class RealEstateOrganizationWidget extends StatelessWidget {
  const RealEstateOrganizationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            (homeCubit.auctionData!.logos?.length ?? 0) > 0
                ? ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 56, maxHeight: 56),
                    child: CachedNetworkImageWidegt(
                      imageUrl: homeCubit.auctionData!.logos?[0].logo ?? '',
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(width: 12),
            (homeCubit.auctionData!.logos?.length ?? 0) > 1
                ? ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 56, maxHeight: 56),
                    child: CachedNetworkImageWidegt(
                      imageUrl: homeCubit.auctionData!.logos?[1].logo ?? '',
                    ),
                  )
                : SizedBox.shrink(),
            Spacer(),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 155, maxHeight: 43),
              child: SvgPicture.asset(
                AppAssets.app_imagesInfath,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        8.verticalSpace,
        const Divider(),
        8.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'وكيل البيع',
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: AppColors.inputsPlaceholder(context)),
            ),
            Text(
              homeCubit.auctionData?.provider?.companyName ??
                  'السعودية للمزادات',
              style: AppStyles.styleMedium14(
                context,
              ).copyWith(color: AppColors.typographyHeading(context)),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'رخصة فال للمزادات العقارية',
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: AppColors.inputsPlaceholder(context)),
            ),
            Text(
              homeCubit.auctionData?.provider?.valAuctionsLicenseNumber ??
                  '',
              style: AppStyles.styleMedium14(
                context,
              ).copyWith(color: AppColors.typographyHeading(context)),
            ),
          ],
        ),
        12.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'رقم الموافقة لإقامة المزاد',
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: AppColors.inputsPlaceholder(context)),
            ),
            Text(
              homeCubit.auctionData?.auctionApprovalNumber??
                  '',
              style: AppStyles.styleMedium14(
                context,
              ).copyWith(color: AppColors.typographyHeading(context)),
            ),
          ],
        ),
        8.verticalSpace,
        const Divider(),
        8.verticalSpace,
        WhatsAppAndCallButtonWidget(),
      ],
    );
  }
}

class WhatsAppAndCallButtonWidget extends StatelessWidget {
  const WhatsAppAndCallButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    final key =
        homeCubit.auctionData?.provider?.companyPhoneNumber?.key ??
        homeCubit.auctionData?.provider?.auctionPhoneNumber?.key;

    final number =
        homeCubit.auctionData?.provider?.companyPhoneNumber?.number ??
        homeCubit.auctionData?.provider?.auctionPhoneNumber?.number;

    String? whatsappNumber = (key != null || number != null)
        ? '${key ?? ''}${number ?? ''}'
        : null;

    return Row(
      children: [
        Expanded(
          child: AppPrimaryButton(
            onPressed: () {
              if (whatsappNumber != null) {
                openLink('https://wa.me/${whatsappNumber}');
                print(
                  homeCubit.auctionData?.provider?.auctionPhoneNumber?.number,
                );
              } else {
                FloatingSnackBar.show(context, 'عذرا لا يوجد رقم حاليا');
              }
            },
            text:  'مراسلة عبر الواتساب',
            icon:   AppAssets.app_imagesWhatsappinfathCard,
          ),
        ),
        8.horizontalSpace,
        AppOutlinedButton(
          width: 64.w,
          onPressed: () {
            if (whatsappNumber != null) {
              callPhoneNumber(whatsappNumber);
            } else {
              FloatingSnackBar.show(context, 'عذرا لا يوجد رقم حاليا');
            }
          },
          text: '',
          icon: AppAssets.app_imagesCall,
        ),
      ],
    );
  }
}
