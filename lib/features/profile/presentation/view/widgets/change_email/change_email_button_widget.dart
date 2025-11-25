import 'package:falak/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';

class ChangeEmailButtonWidget extends StatelessWidget {
  const ChangeEmailButtonWidget({super.key, required this.isEmailValid});

  final bool isEmailValid;

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = context.read<ProfileCubit>();

    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          previous.addEmailRequestState != current.addEmailRequestState,
      listener: (context, state) {
        if (state.addEmailRequestState == RequestState.loaded) {
          context.navigateToWithReplacementAndArguments(Routes.oTPScreen, {
            'nextRoute': Routes.userInfoScreen,
            'isEmail': true,
            'totalSteps': 3,
            'currentStep': 2,
            'width': 95.0,
            'title': 'لقد تم إرسال رمز OTP إلى فضلا ادخل الرمز  المرسل الي بريدك الاليكتروني.  يرجى إدخاله أدناه.',
          });
          mySnackBar(
            state.addEmailModelMsg ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: false,
          );
        } else if (state.addEmailRequestState == RequestState.error) {
          mySnackBar(
            state.addEmailError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AppPrimaryButton(
          isDisabled: !isEmailValid,
          isLoading: state.addEmailRequestState == RequestState.loading,
          onPressed: () {
            cubit.addEmail();
          },
          text: 'التالي',
        );
      },
    );
  }
}
