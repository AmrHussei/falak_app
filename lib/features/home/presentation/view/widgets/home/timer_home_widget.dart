import 'dart:async';

import 'package:flutter/material.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimerHomeWidget extends StatefulWidget {
  const TimerHomeWidget({Key? key, required this.auctionData})
    : super(key: key);
  final AuctionData auctionData;

  @override
  State<TimerHomeWidget> createState() => _TimerHomeWidgetState();
}

class _TimerHomeWidgetState extends State<TimerHomeWidget> {
  late int totalSeconds;

  late Timer _timer;

  @override
  void initState() {
    totalSeconds =
        widget.auctionData.timer!.days * 24 * 60 * 60 +
        widget.auctionData.timer!.hours * 60 * 60 +
        widget.auctionData.timer!.minutes * 60 +
        widget.auctionData.timer!.seconds;

    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (totalSeconds > 0) {
          totalSeconds--;
        } else {
          timer.cancel(); // Stop the timer when it reaches zero
        }
      });
    });
  }

  // Convert total seconds into days, hours, minutes, and seconds
  Map<String, int> _timeComponents(int seconds) {
    int days = seconds ~/ (24 * 60 * 60);
    seconds %= (24 * 60 * 60);
    int hours = seconds ~/ (60 * 60);
    seconds %= (60 * 60);
    int minutes = seconds ~/ 60;
    seconds %= 60;

    return {
      'days': days,
      'hours': hours,
      'minutes': minutes,
      'seconds': seconds,
    };
  }

  @override
  Widget build(BuildContext context) {
    final time = _timeComponents(totalSeconds);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _timeBox(context, time['seconds']!, 'ثانية'),
        8.horizontalSpace,
        _timeBox(context, time['minutes']!, 'دقيقة'),
        8.horizontalSpace,

        _timeBox(context, time['hours']!, 'ساعه'),
        8.horizontalSpace,
        _timeBox(context, time['days']!, 'يوم'),
      ],
    );
  }

  Widget _timeBox(BuildContext context, int value, String label) {
    return SizedBox(
      width: 41.w,
      height: 52.h,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 3.r,
        shadowColor: const Color(0xffF4F4F4),
        color: const Color(0xffF6F7F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '$value',
                  style: AppStyles.styleBold16(
                    context,
                  ).copyWith(color: AppColors.titleColor(context)),
                ),
              ),
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: AppStyles.styleRegular11(
                    context,
                  ).copyWith(color: AppColors.typographySubTitle(context)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
