import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/auth/presentation/view_model/auth/auth_cubit.dart';

class PinCodeWidget extends StatefulWidget {
  const PinCodeWidget({
    super.key,
    this.onChanged,
  });

  final Function(String)? onChanged;

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
   TextEditingController _controller= TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = context.read<AuthCubit>();
    Size size = MediaQuery.sizeOf(context);

    return SizedBox(
      width: 600.w,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: PinCodeTextField(
            controller: _controller,
            appContext: context,
            hintCharacter: '-',
            hintStyle: AppStyles.styleSemiBold24(context).copyWith(
              color: AppColors.iconsPrimary(context).withAlpha(127),
            ),
            length: 6,
            obscureText: false,
            autoFocus: true,
            cursorColor: AppColors.secondColor(context),
            keyboardType: TextInputType.number,
            textStyle: AppStyles.styleMedium24(context)
                .copyWith(color: AppColors.secondColor(context)),
            animationType: AnimationType.scale,
            pinTheme: PinTheme(
              fieldHeight: 56.h,
              fieldWidth: size.width > 600 ? 56.w : 50.w,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(12.r),
              activeFillColor: AppColors.white(context),
              activeColor: AppColors.textFieldBorder(context),
              inactiveColor: AppColors.textFieldBorder(context),
              inactiveFillColor: Colors.white,
              selectedColor: AppColors.secondColor(context),
              selectedFillColor: Colors.white,
              borderWidth: 1.w,
            ),
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            onCompleted: (code) {
              cubit.verifyOtp();
            },
            onChanged: (code) {
              otpCode = code;
              if (widget.onChanged != null) {
                widget.onChanged!(code);
              }
            },
          ),
        ),
      ),
    );
  }
}



