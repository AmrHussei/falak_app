import 'package:falak/features/paegs/data/models/social_model.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';

import '../../../../../../core/functions/url_luncher.dart';

class ContactUsCardWidget extends StatelessWidget {
  const ContactUsCardWidget({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.links,
    this.subText,
    this.offices,
  });

  final String? text, icon, subText;
  final Function()? onTap;
  final Map<String, String?>? links;
  final List<Office>? offices;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow(context),
              offset: Offset(0, 4),
              blurRadius: 12.r,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(icon!, height: 44.h, width: 44.w),
              12.horizontalSpace,
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text ?? "",
                  textAlign: TextAlign.start,
                  style: AppStyles.styleMedium16(context),
                ),
                if (offices != null) ...[
                  6.verticalSpace,
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 2.h,
                    children: offices!
                        .map(
                          (office) => InkWell(
                            onTap: () async {
                              await openLink(office.link);
                            },
                            child: Row(
                              children: [
                                Text(
                                  office.name ?? '',
                                  style: AppStyles.styleRegular13(context)
                                      .copyWith(
                                        color: AppColors.secondColor(context),
                                      ),
                                ),
                                4.horizontalSpace,
                                SvgPicture.asset(
                                  Assets.appImagesOurofficeIcon,
                                  height: 14.34.h,
                                  width: 14.34.w,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
                if (subText != null) ...[
                  6.verticalSpace,
                  Text(
                    subText ?? '',
                    textAlign: TextAlign.center,
                    style: AppStyles.styleRegular13(
                      context,
                    ).copyWith(color: AppColors.secondColor(context)),
                  ),
                ],
              ],
            ),
            if (links != null) ...[
              24.horizontalSpace,
              Flexible(
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 2.h,
                  children: [
                    for (int index = 0; index < links!.length; index++)
                      if (links!.values.elementAt(index) != null)
                        InkWell(
                          onTap: () async {
                            await openLink(links!.values.elementAt(index));
                          },
                          child: links!.keys.elementAt(index).endsWith('png')
                              ? Image.asset(
                                  links!.keys.elementAt(index),
                                  height: 24.h,
                                  width: 24.w,
                                )
                              : SvgPicture.asset(
                                  links!.keys.elementAt(index),
                                  height: 24.h,
                                  width: 24.w,
                                ),
                        ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
