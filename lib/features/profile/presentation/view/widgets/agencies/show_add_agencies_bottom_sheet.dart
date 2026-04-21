import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/profile/presentation/view/widgets/agencies/create_agencies_button_widget.dart';
import 'package:falak/features/profile/presentation/view/widgets/agencies/picked_agency_attachment_widget.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../auth/presentation/view/widgets/sign_up/date_picker_widegt.dart';

Future<void> showAddAgenciesBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white(context),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 32,
              bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: context.read<ProfileCubit>().createAgenciesKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'إضافة وكالة',
                          style: AppStyles.styleBold18(context).copyWith(
                            color: AppColors.typographyHeading(context),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: SvgPicture.asset(
                            AppAssets.app_imagesCloseSquare,
                          ),
                        ),
                      ],
                    ),
                    32.verticalSpace,
                    TextFormFieldWithTitleWidget(
                      controller: context
                          .read<ProfileCubit>()
                          .agencyNameController,
                      title: 'إسم الوكالة',
                      hint: 'إسم الوكالة',
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك ادخل اسم الوكالة';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,
                    TextFormFieldWithTitleWidget(
                      controller: context
                          .read<ProfileCubit>()
                          .agencyNumberController,
                      title: 'رقم الوكالة',
                      hint: 'رقم الوكالة',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك ادخل رقم الوكالة';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,
                    TextFormFieldWithTitleWidget(
                      controller: context
                          .read<ProfileCubit>()
                          .agencyIdentityNumberController,
                      title: 'هويه الموكل',
                      hint: 'هويه الموكل',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك ادخل هويه الموكل';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,
                    DatePickerWidegt(
                      text: 'تاريخ اصدار الوكالة',
                      controller: context
                          .read<ProfileCubit>()
                          .agencyIssuedDateController,
                      filled: false,
                    ),
                    16.verticalSpace,
                    PickedAgencyAttachmentWidget(),
                    16.verticalSpace,
                    Text(
                      'الشركة تخلي مسؤليتها في حالة إلغاء الوكالة أثناء المزاد وفي حالة إلغاء الوكالة يجب علي الوكيل حذفها من النظام',
                      style: AppStyles.styleSemiBold16(
                        context,
                      ).copyWith(color: AppColors.primary(context)),
                    ),
                    16.verticalSpace,

                    CreateAgenciesButtonWidget(
                      profileCubit: context.read<ProfileCubit>(),
                    ),
                    24.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
