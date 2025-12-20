import 'package:falak/core/extensions/string_sxtensions.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/profile/presentation/view/widgets/agencies/delete_agency_widget.dart';
import 'package:falak/core/widgets/success_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:falak/core/utils/app_strings.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/widgets/empty_widget.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../data/models/agencies_model.dart';

class LoadedAgenciesWidget extends StatelessWidget {
  const LoadedAgenciesWidget({super.key, required this.agencies});

  final List<Agency> agencies;

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    final title = profileCubit.status.title;
    final bgColor = profileCubit.status.bgColor;
    final textColor = profileCubit.status.textColor;
    final borderColor = profileCubit.status.borderColor;
    return agencies.isEmpty
        ? Center(
            child: EmptyWidget(
              title: 'لا توجد وكالات ',
            ),
          )
        : Container(
            margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap:
                      (profileCubit.status == AppStrings.rejected ||
                          profileCubit.status == AppStrings.blocked)
                      ? () {
                        showModalBottomSheet(
                          isDismissible: true,
                          isScrollControlled: true,
                          enableDrag: false,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (_) => SuccessBottomSheet(
                            title: 'سبب الرفض',
                            subText:  agencies[index].status?.reason ??
                                'تم رفض الوكالة لاسباب تتعلق بالادمن',
                            haveButton: false,
                            haveImage: false,
                            height: 300.h,
                            action: () {
                              context.pop();
                            },
                          ),
                        );
                        }
                      : null,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: AppColors.backgroundTertiary(context),
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    profileCubit.status.icon,
                                    height: 30.h,
                                    width: 30.w,
                                  ),
                                  8.horizontalSpace,
                                  Text(
                                    agencies[index].agencyName,
                                    style: AppStyles.styleSemiBold16(context)
                                        .copyWith(
                                          color: AppColors.typographyHeading(
                                            context,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: ShapeDecoration(
                                  color: bgColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.r),
                                    side: BorderSide(
                                      width: 1.w,
                                      color: borderColor,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  title,
                                  style: AppStyles.styleBold14(
                                    context,
                                  ).copyWith(color: textColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        8.verticalSpace,
                        Divider(endIndent: 0, indent: 0),
                        8.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),

                          child: Column(
                            children: [
                              AgencyRowTextWidget(
                                title: 'رقم الوكالة',
                                desc: agencies[index].agencyNumber,
                              ),
                              8.verticalSpace,
                              AgencyRowTextWidget(
                                title:
                                    (profileCubit.status == AppStrings.pending)
                                    ? 'تاريخ إصدار الوكالة :'
                                    : 'تاريخ انتهاء الوكالة :',
                                desc:
                                    (profileCubit.status == AppStrings.pending)
                                    ? DateFormat(
                                        "yyyy-MM-dd",
                                      ).format(agencies[index].agencyIssuedDate)
                                    : (agencies[index].expireAt == null)
                                    ? 'غير موجود'
                                    : DateFormat(
                                        "yyyy-MM-dd",
                                      ).format(agencies[index].expireAt!),
                              ),
                            ],
                          ),
                        ),
                        8.verticalSpace,
                        Divider(endIndent: 0, indent: 0),
                        8.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AppAssets.app_imagesPdfIcon,
                                    height: 19.h,
                                    width: 19.w,
                                  ),
                                  8.horizontalSpace,
                                  Text(
                                    'مرفق الوكالة.${agencies[index].agencyAttachment.split('.').last}',
                                    style: AppStyles.styleRegular14(context)
                                        .copyWith(
                                          color: AppColors.inputsPlaceholder(
                                            context,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                              if (profileCubit.status == AppStrings.approved)
                                DeleteAgencyWidget(
                                  agencyId: agencies[index].id,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: agencies.length,
            ),
          );
  }
}

class AgencyRowTextWidget extends StatelessWidget {
  const AgencyRowTextWidget({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: AppStyles.styleRegular14(
              context,
            ).copyWith(color: AppColors.inputsPlaceholder(context)),
          ),
        ),
        Expanded(
          child: Text(
            desc,
            textAlign: TextAlign.start,
            style: AppStyles.styleRegular14(
              context,
            ).copyWith(color: AppColors.typographyHeading(context)),
          ),
        ),
      ],
    );
  }
}
