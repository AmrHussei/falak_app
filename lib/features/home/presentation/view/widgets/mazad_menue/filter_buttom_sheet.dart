import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/core/widgets/global_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/features/home/presentation/view/widgets/mazad_menue/mazad_type_dropdown_button_form_field_widget.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../../core/utils/app_images.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';
import '../../../../../profile/presentation/view_model/profile/profile_cubit.dart';

Future<void> filterSheetBottomSheet(BuildContext context) async {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (context) {
      return FilterSheetBottomSheetBodyWidget();
    },
  );
}

class FilterSheetBottomSheetBodyWidget extends StatefulWidget {
  const FilterSheetBottomSheetBodyWidget({super.key});

  @override
  State<FilterSheetBottomSheetBodyWidget> createState() =>
      _FilterSheetBottomSheetBodyWidgetState();
}

class _FilterSheetBottomSheetBodyWidgetState
    extends State<FilterSheetBottomSheetBodyWidget>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().agencyId = null;
    context.read<ProfileCubit>().status = AppStrings.approved;
    context.read<ProfileCubit>().getAgencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = context.read<HomeCubit>();
    return GlobalBottomSheet(
      height: 350.h,
      title: 'البحث',
      action: () {
        context.pop();
      },
      child: Column(
        children: [
          TextFormFieldWithTitleWidget(
            title: 'اسم المزاد',
            hint: 'اسم المزاد',
            controller: homeCubit.auctionFilterSearch,
            prefix: Padding(
              padding: EdgeInsetsDirectional.only(start: 16, end: 8.w),
              child: SizedBox(
                width: 20,
                height: 20,
                child: InkWell(
                  child: SvgPicture.asset(
                    Assets.imagesMagnifer,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          16.verticalSpace,
          MazadtypeDropdownButtonFormFieldWidget(),
          32.verticalSpace,
          Row(
            children: [
              AppOutlinedButton(
                width: 70.w,
                onPressed: () {
                  homeCubit.filterAuctiontype = null;
                  homeCubit.auctionFilterSearch.clear();
                  homeCubit.refreshAuctionsForTab();
                  context.pop();
                },
                text: 'الغاء',
              ),
              12.horizontalSpace,
              Expanded(
                child: AppPrimaryButton(
                  onPressed: () {
                    context.pop();
                    homeCubit.refreshAuctionsForTab();
                  },
                  text: 'بحث',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
