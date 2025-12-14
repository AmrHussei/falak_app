// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/utils/media_query_values.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

// ignore: must_be_immutable
class TextFormFieldWithTitleWidget extends StatefulWidget {
  TextFormFieldWithTitleWidget({
    super.key,
    this.showBorder = true,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.textCapitalization,
    this.autofocus,
    this.obscureText,
    this.suffix,
    this.prefix,
    this.enabled,
    this.label,
    thisint,
    this.validator,
    this.filled,
    this.fillColor,
    this.textColor,
    this.onFieldSubmitted,
    this.errorWidget,
    this.inputFormatters,
    this.prefixIconSize,
    this.suffixIconSize,
    this.maxLines = 1,
    this.enabledBorderColore,
    this.onTap,
    this.onChanged,
    this.hint,
    this.title,
    this.hintStyle,
  });
  final TextEditingController? controller;
  final double? prefixIconSize;
  final double? suffixIconSize;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final bool? autofocus;
  final bool? obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final bool? enabled;
  final String? hint;
  final String? label;
  final String? Function(String?)? validator;
  Function(String?)? onChanged;
  final bool? filled;
  final Color? fillColor;
  final Color? textColor;
  final Color? enabledBorderColore;
  final void Function(String)? onFieldSubmitted;
  final Widget? errorWidget;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final bool showBorder;
  final VoidCallback? onTap;
  final String? title;
  final TextStyle? hintStyle;

  @override
  State<TextFormFieldWithTitleWidget> createState() =>
      _TextFormFieldWithTitleWidgetState();
}

class _TextFormFieldWithTitleWidgetState
    extends State<TextFormFieldWithTitleWidget> {
  late FocusNode _internalFocusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    } else {
      _internalFocusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _internalFocusNode.hasFocus;
    });
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
        widget.title != null
            ? Text(
                widget.title ?? '',
                style: AppStyles.styleSemiBold14(context),
              )
            : SizedBox.shrink(),
        widget.title != null ? 6.verticalSpace : SizedBox.shrink(),
        SizedBox(
          child: TextFormField(
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText ?? false,
            autofocus: widget.autofocus ?? false,
            enabled: widget.enabled ?? true,
            cursorColor: AppColors.primary(context),
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: widget.onFieldSubmitted,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            focusNode: _internalFocusNode,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            style: AppStyles.styleSemiBold16(context),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),

              prefixIconConstraints: widget.prefixIconSize == null
                  ? null
                  : BoxConstraints(
                      maxHeight: widget.prefixIconSize!,
                      maxWidth: widget.prefixIconSize!,
                    ),
              suffixIconConstraints: widget.suffixIconSize == null
                  ? null
                  : BoxConstraints(
                      maxHeight: widget.suffixIconSize!,
                      maxWidth: widget.suffixIconSize!,
                    ),
              filled: widget.filled ?? true,
              fillColor: widget.fillColor ?? AppColors.white(context),
              focusColor: AppColors.white(context),
              iconColor: context.theme.colorScheme.shadow,
              prefixIconColor: AppColors.iconsThAndTCaptions(context),
              suffixIconColor: _isFocused
                  ? AppColors.secondColor(context)
                  : AppColors.iconsPrimary(context),
              prefixIcon: widget.prefix,
              suffixIcon: widget.suffix != null
                  ? (_isFocused
                        ? ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              AppColors.secondColor(context),
                              BlendMode.srcIn,
                            ),
                            child: widget.suffix,
                          )
                        : widget.suffix)
                  : null,
              // suffix: suffix,
              hintText: widget.hint,
              hintStyle: widget.hintStyle ?? AppStyles.styleRegular14(context),
              label: Text(widget.label ?? ''),
              labelStyle: AppStyles.styleRegular16(context).copyWith(
                color: widget.enabled == false
                    ? AppColors.typographyBody(context)
                    : AppColors.typographyBody(context),
              ),
              floatingLabelStyle: AppStyles.styleRegular14(
                context,
              ).copyWith(color: AppColors.primary(context)),
              floatingLabelBehavior: FloatingLabelBehavior.always,

              //OutlineInputBorder
              border: _border,
              enabledBorder: _border,
              disabledBorder: _border,
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppColors.error(context),
                  width: 1,
                ),
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
          ),
        ),
        widget.errorWidget ?? const SizedBox.shrink(),
      ],
    );
  }
}
