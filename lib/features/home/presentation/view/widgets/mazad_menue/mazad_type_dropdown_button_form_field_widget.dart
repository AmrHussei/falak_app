import 'package:falak/core/widgets/custom_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/utils/app_styles.dart';

class MazadtypeDropdownButtonFormFieldWidget extends StatefulWidget {
  const MazadtypeDropdownButtonFormFieldWidget({super.key});

  @override
  State<MazadtypeDropdownButtonFormFieldWidget> createState() =>
      _MazadtypeDropdownButtonFormFieldWidgetState();
}

class _MazadtypeDropdownButtonFormFieldWidgetState
    extends State<MazadtypeDropdownButtonFormFieldWidget> {
  String? selectedValue;
  final List<String> options = ['الكترونى', 'هجين', 'حضوري'];

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    selectedValue = homeCubit.filterAuctiontypeAr;
    return CustomDropdownWidget<String>(
      initialValue: selectedValue,
      title: 'نوع المزاد',

      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      items: options
          .map(
            (type) => DropdownMenuItem<String>(
              value: type,
              onTap: () {
                if (type == 'الكترونى') {
                  homeCubit.filterAuctiontype = AppStrings.online;
                  homeCubit.filterAuctiontypeAr = 'الكترونى';
                }
                if (type == 'هجين') {
                  homeCubit.filterAuctiontype = AppStrings.hybrid;
                  homeCubit.filterAuctiontypeAr = 'هجين';
                }
                if (type == 'حضوري') {
                  homeCubit.filterAuctiontype = AppStrings.offline;
                  homeCubit.filterAuctiontypeAr = 'حضوري';
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  type,
                  style: AppStyles.styleBold16(
                    context,
                  ).copyWith(color: AppColors.typographyHeading(context)),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
