import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/utils/app_colors.dart' show AppColors;
import '../../../../../../core/utils/images.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key, required this.isFavorite, this.onTab});

  final bool isFavorite;
  final Function? onTab;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTab?.call();
      },
      child: SizedBox(
        width: 26,

        height: 26,
        child: SvgPicture.asset(
          AppAssets.imagesSave,
          color: isFavorite == true
              ? AppColors.primary(context)
              : AppColors.grey500(context),
          height: 32.h,
          width: 32.w,
        ),
      ),
    );
  }
}
