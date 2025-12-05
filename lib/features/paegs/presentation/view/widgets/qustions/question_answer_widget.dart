import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../data/models/question_model.dart';

class QuestionAnswerWidget extends HookWidget {
  final Data model;

  const QuestionAnswerWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final show = useState(false);
    return ExpansionTile(
      backgroundColor: Colors.white,
      collapsedBackgroundColor: Colors.white,
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: const Color(0xffE7E9E9)),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      trailing: SvgPicture.asset(
        show.value ? Assets.imagesArrowTop : Assets.imagesArrowBottom,
        height: 24.h,
        width: 24.w,
      ),

      title: Text(
        model.question,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        style: show.value
            ? AppStyles.styleMedium14(
                context,
              ).copyWith(color: AppColors.typographyHeading(context))
            : AppStyles.styleRegular14(
                context,
              ).copyWith(color: AppColors.grayText(context)),
      ),
      onExpansionChanged: (value) {
        show.value = value;
      },
      childrenPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      children: [
        Html(
          data: model.answer,
          style: {
            "body": Style(
              fontFamily: 'Lama Sans',
              lineHeight: LineHeight(1.7),
              color: AppColors.grayText(context),
              fontSize: FontSize(16),
            ),
          },
        ),
      ],
    );
  }
}
