import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/utils/media_query_values.dart';

class CoustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  CoustomAppBarWidget({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.bottom,
    this.hight,
  });

  final String? title;
  List<Widget>? actions;
  Widget? leading;
  PreferredSizeWidget? bottom;
  double? hight;

  @override
  Widget build(BuildContext context) {
    bool canPop = Navigator.canPop(context);

    return AppBar(
      bottom: bottom,
      elevation: 0,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      foregroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: hight ?? 64,
      centerTitle: false,
      flexibleSpace: Container(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(
              title ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppStyles.styleBold16(
                context,
              ).copyWith(color: AppColors.typographyHeading(context)),
            ),
          ),
        ],
      ),
      actions: actions,
      leadingWidth: canPop
          ? 68
          : leading != null
          ? 8.w
          : 0,
      leading: leading != null
          ? leading!
          : canPop
          ? InkWell(
              onTap: () {
                context.pop();
              },
              child: PopWidget(),
            )
          : SizedBox.shrink(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(hight ?? 56);
}

class PopWidget extends StatelessWidget {
  const PopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: EdgeInsetsDirectional.only(start: 24, top: 6, bottom: 6),
      decoration: ShapeDecoration(
        color: const Color(0xFFFAFAFA) /* Surface-primary */,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: const Color(0xFFE1E1E2) /* Borders-primary */,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: FittedBox(
        child: SvgPicture.asset(AppAssets.app_imagesArrow, fit: BoxFit.contain),
      ),
    );
  }
}
