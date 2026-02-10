import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/paegs/presentation/view_model/pages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectTypeRadioButton extends StatefulWidget {
  const SelectTypeRadioButton({super.key});

  @override
  State<SelectTypeRadioButton> createState() => _SelectTypeRadioButtonState();
}

class _SelectTypeRadioButtonState extends State<SelectTypeRadioButton> {
  String? _selectedValue = 'suggestion';

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedValue = value;
      context.read<PagesCubit>().typeOfContactUs = _selectedValue!;
      print(_selectedValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: Column(
        children: [
          Row(
            children: [
              RadioItem(
                label: 'استفسار',
                value: 'suggestion',
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
                context: context,
              ),
              8.horizontalSpace,
              RadioItem(
                label: 'شكوى',
                value: 'question',
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
                context: context,
              ),
              8.horizontalSpace,

              RadioItem(
                label: 'إقتراح',
                value: 'complaint',
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
                context: context,
              ),
              8.horizontalSpace,
              RadioItem(
                label: 'اخرى',
                value: 'other',
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
                context: context,
              ),
            ],
          ),
          8.verticalSpace,
          RadioItem(
            label: 'تغير بيانات شخصية',
            value: 'changePersonalInformation',
            groupValue: _selectedValue,
            onChanged: _handleRadioValueChange,
            context: context,
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xFFE9E9E9)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 8;
    double dashSpace = 5;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Widget RadioItem({
  required String label,
  required String value,
  required String? groupValue,
  required ValueChanged<String?> onChanged,
  required BuildContext context,
}) {
  return Expanded(
    child: SizedBox(
      height: 41.h,
      child: InkWell(
        onTap: () {
          onChanged(value);
        },
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          margin: EdgeInsets.zero,
          color: value == groupValue
              ? AppColors.secondColor(context)
              : Colors.white,
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: AppStyles.styleMedium14(context).copyWith(
                color: value == groupValue
                    ? Colors.white
                    : AppColors.typographyHeading(context),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
