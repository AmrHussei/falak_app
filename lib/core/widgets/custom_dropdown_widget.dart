import 'package:falak/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';

class CustomDropdownWidget<T> extends StatefulWidget {
  final String? title;
  final String? label;
  final String? hint;
  final List<DropdownMenuItem<T>> items;
  final T? initialValue;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool showClearButton;
  final VoidCallback? onClear;
  final TextStyle? hintStyle;

  const CustomDropdownWidget({
    super.key,
    this.title,
    this.label,
    this.hint,
    required this.items,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.showClearButton = true,
    this.onClear,
    this.hintStyle,
  });

  @override
  State<CustomDropdownWidget<T>> createState() =>
      _CustomDropdownWidgetState<T>();
}

class _CustomDropdownWidgetState<T> extends State<CustomDropdownWidget<T>> {
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: AppColors.textFieldBorder(context),
        width: 1,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(widget.title!, style: AppStyles.styleSemiBold14(context)),
          6.verticalSpace,
        ],
        DropdownButtonFormField<T>(
          value: selectedValue,
          menuMaxHeight: 600,
          dropdownColor: AppColors.white(context),
          style: AppStyles.styleSemiBold16(context),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            widget.onChanged?.call(value);
          },
          validator: widget.validator,
          items: widget.items,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white(context),
            focusColor: AppColors.white(context),
            hintText: widget.hint,
            hintStyle:
                widget.hintStyle ??
                AppStyles.styleRegular14(context).copyWith(fontSize: 16),
            label: widget.label != null ? Text(widget.label!) : null,
            labelStyle: AppStyles.styleRegular16(
              context,
            ).copyWith(color: AppColors.typographyBody(context)),
            floatingLabelStyle: AppStyles.styleRegular14(
              context,
            ).copyWith(color: AppColors.primary(context)),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: _border,
            enabledBorder: _border,
            disabledBorder: _border,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.error(context), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.primary(context),
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: AppColors.primary(context),
                width: 1,
              ),
            ),
          ),
          icon: selectedValue == null || !widget.showClearButton
              ? SizedBox(
                  width: 32.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: SvgPicture.asset(
                      Assets.imagesArrowDown,
                      width: 24.w,
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    setState(() {
                      selectedValue = null;
                    });
                    widget.onClear?.call();
                  },
                  child: SvgPicture.asset(Assets.imagesCloseIcon),
                ),
        ),
      ],
    );
  }
}
