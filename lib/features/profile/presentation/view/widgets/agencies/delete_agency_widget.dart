import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/my_snackbar.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_images.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';

class DeleteAgencyWidget extends StatelessWidget {
  const DeleteAgencyWidget({super.key, required this.agencyId});

  final String agencyId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDeleteAgencyBottomSheet(context, agencyId);
      },
      child: Container(
        height: 40.h,
        width: 94.w,
        decoration: BoxDecoration(
          color: AppColors.white(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.iconsTertiary(context)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.app_imagesDelete,
              height: 16.h,
              width: 16.w,
            ),
            4.horizontalSpace,
            Text(
              'حذف',
              style: AppStyles.styleRegular14(
                context,
              ).copyWith(color: AppColors.error2(context)),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showDeleteAgencyBottomSheet(
  BuildContext context,
  String agencyId,
) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return IntrinsicHeight(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white(context),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              children: [
                SvgPicture.asset(Assets.imagesDeleteAccount),
                16.verticalSpace,
                Text(
                  'حذف الوكالة', // Format DateTime
                  style: AppStyles.stylBold24(context),
                ),
                16.verticalSpace,
                Text(
                  'هل أنت متأكد أنك تريد حذف الوكالة نهائيا؟',
                  // Format DateTime
                  style: AppStyles.styleSemiBold18(
                    context,
                  ).copyWith(color: AppColors.typographySubTitle(context)),
                ),
                24.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: AppOutlinedButton(
                          radius: 8.r,
                          onPressed: () {
                          context.pop();
                        },
                        text: 'إلغاء',
                        icon: Assets.imagesClose,
                        iconColor:AppColors.secondColor(context)
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child:  BlocConsumer<ProfileCubit, ProfileState>(
                        listenWhen: (previous, current) =>
                        previous.deleteAgenciesRequestState !=
                            current.deleteAgenciesRequestState,
                        listener: (context, state) {
                          if (state.deleteAgenciesRequestState ==
                              RequestState.loaded) {
                            context.pop();
                            mySnackBar(
                              state.deleteAccountMsg ?? 'تم حذف الوكالة',
                              context,
                              isError: false,
                            );
                            context.read<ProfileCubit>().getAgencies();
                          } else if (state.deleteAgenciesRequestState ==
                              RequestState.error) {
                            mySnackBar(
                              state.deleteAccountError?.message ??
                                  'هناك شئ ما خطأ حاول مجددا',
                              context,
                              isError: true,
                            );
                          }
                        },
                        builder: (context, state) {
                          return AppPrimaryButton(
                            radius: 8.r,
                            onPressed: () {
                              context.read<ProfileCubit>().agencyId = agencyId;
                              context.read<ProfileCubit>().deleteAgencies();                        },
                            text: 'حذف',
                            icon: Assets.imagesDelete,
                            isLoading: state.deleteAgenciesRequestState ==
                                RequestState.loading,
                              iconColor:AppColors.white(context)

                          );

                        },
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
