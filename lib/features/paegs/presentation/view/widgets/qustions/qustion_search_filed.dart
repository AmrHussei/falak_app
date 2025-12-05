import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/features/paegs/presentation/view_model/pages_cubit.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';

class QustionSearchFiled extends StatelessWidget
    implements PreferredSizeWidget {
  const QustionSearchFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PagesCubit pagesCubit = context.read<PagesCubit>();

    return TextFormFieldWithTitleWidget(
      controller: pagesCubit.questionsSearchController,
      onChanged: (p0) {
        pagesCubit.getQuestions();
      },

      hint: 'البحث عن الأسئلة',
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return '';
        }
        return null;
      },
      prefix: Padding(
        padding: EdgeInsetsDirectional.only(end: 8, start: 16),
        child: SizedBox(
          width: 16.w,
          height: 16.h,
          child: InkWell(
            child: SvgPicture.asset(
              Assets.imagesMagnifer,
              fit: BoxFit.contain,
              color: AppColors.iconsPrimary(context),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(30.h);
}
