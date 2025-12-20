import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/success_bottom_sheet.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';

class ChangePasswordButtonWidget extends StatelessWidget {
  const ChangePasswordButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = context.read<ProfileCubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocConsumer<ProfileCubit, ProfileState>(
          listenWhen: (previous, current) =>
              previous.changePasswordRequestState !=
              current.changePasswordRequestState,
          listener: (context, state) {
            if (state.changePasswordRequestState == RequestState.loaded) {
              showModalBottomSheet(
                isDismissible: true,
                isScrollControlled: true,
                enableDrag: false,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (_) => const SuccessBottomSheet(),
              );
            } else if (state.changePasswordRequestState == RequestState.error) {
              mySnackBar(
                state.changePasswordError?.message ??
                    'هناك شئ ما خطأ حاول مجددا',
                context,
                isError: true,
              );
            }
          },
          builder: (context, state) {
            return AppPrimaryButton(
              isLoading:
                  state.changePasswordRequestState == RequestState.loading,
              onPressed: () {
                cubit.changePassword();
              },
              text: 'تأكيد',
            );
          },
        ),
        16.verticalSpace,
      ],
    );
  }
}
