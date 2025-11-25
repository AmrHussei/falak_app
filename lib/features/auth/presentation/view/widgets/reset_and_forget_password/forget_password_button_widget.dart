import 'package:falak/core/widgets/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/core/utils/media_query_values.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../view_model/auth/auth_cubit.dart';

class ForgetPasswordButtonWidget extends StatelessWidget {
  const ForgetPasswordButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.forgetPassWordRequestState !=
          current.forgetPassWordRequestState,
      listener: (context, state) {
        if (state.forgetPassWordRequestState == RequestState.loaded) {
          context.navigateToWithArguments(Routes.oTPScreen, {
            'nextRoute': Routes.resetPasswordScreen,
            'totalSteps': 3,
            'currentStep': 1,
            'width': 95.0,
          });
          mySnackBar(
            state.forgetPassWordMsg ?? 'تم ارسال الرمز',
            context,
            isError: false,
          );
        } else if (state.forgetPassWordRequestState == RequestState.error) {
          mySnackBar(
            state.forgetPassWordError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AppPrimaryButton(
          isLoading: state.forgetPassWordRequestState == RequestState.loading,
          onPressed: () {
            cubit.forgetPassword();
          },
          text: 'التحقق',
        );
      },
    );
  }
}
