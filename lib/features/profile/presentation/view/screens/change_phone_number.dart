import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/phone_suffix_widget.dart';
import 'package:falak/features/auth/presentation/view/widgets/steps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../config/routes/app_routes.dart';
import '../../../../../../core/utils/app_animations.dart';
import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/widgets/adaptive_layout_widget.dart';
import '../../../../../core/widgets/coustom_app_bar_widget.dart';
import '../../../../../core/widgets/text_form_field_with_title_widget.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({super.key});

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  @override
  void initState() {
    if (Kphone != null) {
      context.read<ProfileCubit>().editablePhoneController.text = Kphone!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoustomAppBarWidget(
        title: 'رقم الجوال',
        actions: [
          StepsWidget(currentStep: 1, totalSteps: 3, width: 17.w),
          8.horizontalSpace,
        ],
      ),
      body: AdaptiveLayout(
        mobileLayout: (context) => ChangePhoneNumberMobileLayoutWidget(),
        tabletLayout: (context) => Center(
          child: SizedBox(
            height: 1.sw,
            width: 600,
            child: ChangePhoneNumberMobileLayoutWidget(),
          ),
        ),
      ),
    );
  }
}

class ChangePhoneNumberMobileLayoutWidget extends StatelessWidget {
  const ChangePhoneNumberMobileLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = context.read<ProfileCubit>();
    return Form(
      key: cubit.editphoneKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 31.5.w, vertical: 32.h),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWithTitleWidget(
              controller: cubit.editablePhoneController,
              title: 'رقم الجوال الجديد',
              hint: 'رقم الجوال الجديد',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى ادخال رقم الجوال';
                }
                if (!RegExp(r'^5\d{8}$').hasMatch(value)) {
                  return 'يجب أن يبدأ رقم الجوال ب 5 ويتكون من 9 أرقام';
                }
                return null;
              },
              inputFormatters: [LengthLimitingTextInputFormatter(9)],
              keyboardType: TextInputType.number,
              suffixIconSize: 66.w,              isPhone: true,

              suffix: PhoneSuffixWidget(),
            ),
            16.verticalSpace,
            ChangePhoneNumberButtonWidget(),
            31.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class ChangePhoneNumberButtonWidget extends StatelessWidget {
  const ChangePhoneNumberButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit = context.read<ProfileCubit>();

    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          previous.addPhoneRequestState != current.addPhoneRequestState,
      listener: (context, state) {
        if (state.addPhoneRequestState == RequestState.loaded) {
          context.navigateToWithArguments(Routes.oTPScreen, {
            'nextRoute': Routes.userInfoScreen,
            'totalSteps': 3,
            'currentStep': 3,
            'width': 95.0,
            'title': 'فضلا ادخل الرمز  المرسل الي بريدك الاليكتروني',
          });
          mySnackBar(state.addPhoneModelMsg ?? 'تم', context, isError: false);
        } else if (state.addPhoneRequestState == RequestState.error) {
          mySnackBar(
            state.addPhoneError?.message ?? 'هناك شئ ما خطأ حاول مجددا',
            context,
            isError: true,
          );
        }
      },
      builder: (context, state) {
        return AppPrimaryButton(
          onPressed: () {
            cubit.addPhone();
          },
          text: 'التالي',
          isLoading: state.addPhoneRequestState == RequestState.loading,
        );
      },
    );
  }
}
