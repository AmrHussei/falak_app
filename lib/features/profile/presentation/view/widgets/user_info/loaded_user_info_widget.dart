import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/config/routes/app_routes.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/my_snackbar.dart';
import 'package:falak/features/auth/presentation/view_model/auth/auth_cubit.dart';
import 'package:falak/features/profile/data/models/profile_model.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';

class LoadedUserInfoWidget extends StatelessWidget {
  const LoadedUserInfoWidget({super.key, required this.profileModel});

  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 31.5.w, vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              return Row(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17.r),
                      border: Border.all(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFFC5C9C9),
                      ),
                    ),
                    child: profileCubit.imageFile == null
                        ? CachedNetworkImage(
                            imageUrl: profileModel.data.profileImage ?? '',
                            placeholder: (_, _) =>
                                Image.asset(AppAssets.app_imagesUserCircle),
                            errorWidget: (_, _, _) =>
                                Image.asset(AppAssets.app_imagesUserCircle),
                          )
                        : Image.file(profileCubit.imageFile!),
                  ),
                  12.horizontalSpace,
                  InkWell(
                    onTap: () {
                      if (profileCubit.imageFile == null) {
                        profileCubit.pickProfileImage();
                      }
                      if (profileCubit.imageFile != null) {
                        profileCubit.deletePickedImage();
                      }
                    },
                    child: Container(
                      height: 22.h,
                      width: 52.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Color(0xFFC5C9C9),
                        ),
                      ),
                      child: Text(
                        profileCubit.imageFile == null ? 'تعديل' : 'حذف',
                        style: AppStyles.styleRegular14(
                          context,
                        ).copyWith(color: AppColors.grayText(context)),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          40.verticalSpace,
          Row(
            children: [
              Expanded(
                child: TextFormFieldWithTitleWidget(
                  title: 'الإسم الأول',
                  controller: profileCubit.firstNameController,
                  enabled: false,
                  keyboardType: TextInputType.text,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: TextFormFieldWithTitleWidget(
                  title: 'الإسم الثاني',
                  controller: profileCubit.SecondNameController,
                  enabled: false,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          24.verticalSpace,
          Row(
            children: [
              Expanded(
                child: TextFormFieldWithTitleWidget(
                  title: 'الإسم الثالث',
                  controller: profileCubit.thirdNameController,
                  enabled: false,
                  keyboardType: TextInputType.text,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: TextFormFieldWithTitleWidget(
                  title: 'الإسم الاخير',
                  controller: profileCubit.lastNameController,
                  enabled: false,
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),
          24.verticalSpace,
          TextFormFieldWithTitleWidget(
            title: 'الهوية الوطنة / رقم الاقامة',
            controller: profileCubit.identityNumberController,
            inputFormatters: [LengthLimitingTextInputFormatter(10)],
            enabled: false,
            keyboardType: TextInputType.number,
          ),
          24.verticalSpace,
          TextFormFieldWithTitleWidget(
            title: 'رقم الجوال',
            controller: profileCubit.phoneController,
            enabled: false,
            inputFormatters: [LengthLimitingTextInputFormatter(9)],
            keyboardType: TextInputType.number,
            suffixIconSize: 66.w,
            suffix: Container(
              alignment: Alignment.center,
              height: 40.h,
              width: 59.w,
              margin: EdgeInsetsDirectional.only(end: 6.w, start: 1.w),
              decoration: BoxDecoration(
                color: AppColors.containerGrayColor(context),
                borderRadius: BorderRadius.all(Radius.circular(8.r)),
              ),
              child: Text(
                '966+',
                style: AppStyles.styleBold14(
                  context,
                ).copyWith(color: AppColors.veryGrayColor(context)),
              ),
            ),
          ),
          24.verticalSpace,
          BlocListener<ProfileCubit, ProfileState>(
            listenWhen: (previous, current) =>
                previous.askAddEmailRequestState !=
                current.askAddEmailRequestState,
            listener: (context, state) {
              if (state.askAddEmailRequestState == RequestState.loaded) {
                context.navigateToWithArguments(Routes.oTPScreen, {
                  'nextRoute': Routes.changeEmailScreen,
                  'totalSteps': 3,
                  'currentStep': 0,
                  'width': 95.0,
                });
                mySnackBar(
                  state.askAddEmailMsg ?? 'تم ',
                  context,
                  isError: false,
                );
                context.read<AuthCubit>().identityNumberController.text =
                    profileModel.data.identityNumber;
              } else if (state.askAddEmailRequestState == RequestState.error) {
                mySnackBar(
                  state.askAddEmailError?.message ??
                      'هناك شئ ما خطأ حاول مجددا',
                  context,
                  isError: true,
                );
              }
            },
            child: InkWell(
              onTap: () {
                profileCubit.askAddEmail();
              },
              child: IgnorePointer(
                ignoring: true,
                child: TextFormFieldWithTitleWidget(
                  title: 'البريد الاليكتروني ',
                  controller: profileCubit.emailController,
                  validator: (value) {
                    if (value == null) {
                      return 'يرجى ادخال الرقم ';
                    }
                    if (value.isEmpty) {
                      return 'يرجى ادخال الرقم ';
                    }
                    return null;
                  },
                  enabled: true,
                  keyboardType: TextInputType.emailAddress,
                  suffix: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    child: Text(
                      profileModel.data.email == null
                          ? 'ادخل البريد'
                          : 'تغير البريد',
                      style: AppStyles.styleSemiBold14(context).copyWith(
                        color: AppColors.primary(context),
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.secondColor(context),
                        decorationThickness: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          12.verticalSpace,
          profileModel.data.email == null
              ? Row(
                  children: [
                    Text(
                      'يرجى ادخال البريد الالكتروني',
                      style: AppStyles.styleMedium14(
                        context,
                      ).copyWith(color: AppColors.danger(context)),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
