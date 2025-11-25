import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../app/app.dart';
import '../../../../../core/utils/app_animations.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../core/widgets/error_app_widget.dart';
import '../../../../../core/widgets/guest_widget.dart';
import '../widgets/user_info/loaded_user_info_widget.dart';
import '../widgets/user_info/shimmer_user_info_widget .dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().getProfile();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    return Scaffold(
      bottomSheet: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return (profileCubit.imageFile == null &&
                  profileCubit.editUserInfoCountryID == null)
              ? SizedBox.shrink()
              : Container(
                  padding: EdgeInsets.all(16),
                  color: AppColors.white(context),
                  child: ElevatedButton(
                    onPressed: () {
                      profileCubit.changeProfileImage();
                    },
                    child: state.changeProfileImageRequestState ==
                            RequestState.loading
                        ? Lottie.asset(
                            AppAnimationAssets.loading,
                          )
                        : Text(
                            'حفظ التعديلات',
                            style: AppStyles.styleBold18(context)
                                .copyWith(color: AppColors.white(context)),
                          ),
                  ),
                );
        },
      ),
      appBar: CoustomAppBarWidget(
        title: 'المعلومات الشخصية',
      ),
      body: KisGuest == true
          ? GuestWidget()
          : BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                switch (state.profileRequestState) {
                  case RequestState.loading:
                  case RequestState.ideal:
                    return ShimmerUserInfoWidget();
                  case RequestState.error:
                    return ErrorAppWidget(
                      text: state.profileError?.message ?? 'حدث شئ ما خطأ',
                      onTap: () {
                        profileCubit.getProfile();
                      },
                    );
                  case RequestState.loaded:
                    return LoadedUserInfoWidget(
                      profileModel: state.profileModel!,
                    );
                }
              },
            ),
    );
  }
}
