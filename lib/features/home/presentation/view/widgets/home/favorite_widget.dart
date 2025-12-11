
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../generated/assets.dart';

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
      child: SvgPicture.asset(
       isFavorite == true
            ? Assets.appImagesLikedHeart
            : Assets.appImagesFavoriteAuction,
        height: 32.h,
        width: 32.w,
      ),
    );
  }
}
