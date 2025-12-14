import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';

import '../../../../../../core/utils/app_styles.dart';
import '../../../view_model/home/home_cubit.dart';
import '../home/timer_home_widget.dart';

class AssetsCommingStatusTimerWidget extends StatelessWidget {
  const AssetsCommingStatusTimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 92,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: ShapeDecoration(
            color: const Color(0x0C22A06B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ينتهي بعد',
                      style: AppStyles.styleBold16(context).copyWith(
                        color: AppColors.typographyHeading(context),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 16,
                ),
                TimerHomeWidget(
                  auctionData: context.read<HomeCubit>().auctionData!,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }
}

class AssetsDescriptionWidget extends StatefulWidget {
  const AssetsDescriptionWidget({Key? key}) : super(key: key);

  @override
  State<AssetsDescriptionWidget> createState() =>
      _AssetsDescriptionWidgetState();
}

class _AssetsDescriptionWidgetState extends State<AssetsDescriptionWidget> {

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();

    return Text(
      homeCubit.auctionOrigin?.description ?? 'وصف الاصل ',
      style: AppStyles.styleRegular14(context).copyWith(
        color: AppColors.iconsGrey(context),
        fontSize: 18,
        height: 2,
      ),
      textAlign: TextAlign.start,
    );
  }
}
