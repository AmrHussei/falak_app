import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/success_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/my_snackbar.dart';

class CreateAgenciesButtonWidget extends StatelessWidget {
  const CreateAgenciesButtonWidget({super.key, required this.profileCubit});

  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppOutlinedButton(
            onPressed: () {
              context.pop();
            },
            text: 'رجوع',
          ),
        ),
        12.horizontalSpace,
        Expanded(
          flex: 3,
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listenWhen: (previous, current) =>
                previous.createAgencyRequestState !=
                current.createAgencyRequestState,
            listener: (context, state) {
              if (state.createAgencyRequestState == RequestState.loaded) {
                context.pop();
                showModalBottomSheet(
                  isDismissible: false,
                  isScrollControlled: true,
                  enableDrag: false,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) => SuccessBottomSheet(
                    title: 'إضافة وكالة',
                    subText: 'تم ارسال الوكالة بنجاح',
                    haveButton: false,
                    height: 280.h,
                    action: () {
                      context.pop();
                    },
                  ),
                );
                context.read<ProfileCubit>().getAgencies();
              } else if (state.createAgencyRequestState == RequestState.error) {
                FloatingSnackBar.show(
                  context,
                  state.createAgencyError?.message ??
                      'هناك شئ ما خطأ حاول مجددا',
                  isError: true,
                );
              }
            },
            buildWhen: (previous, current) =>
                previous.createAgencyRequestState !=
                current.createAgencyRequestState,
            builder: (context, state) {
              return AppPrimaryButton(
                isLoading:
                    state.createAgencyRequestState == RequestState.loading,

                onPressed: () {
                  profileCubit.createAgency();
                },
                text: 'ارسال طلب الاضافة',
              );
            },
          ),
        ),
      ],
    );
  }
}
