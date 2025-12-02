import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/features/profile/presentation/view_model/profile/profile_cubit.dart';

import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_styles.dart';
import '../../../../../../core/widgets/text_form_field_with_title_widget.dart';

class PickedAgencyAttachmentWidget extends StatefulWidget {
  const PickedAgencyAttachmentWidget({
    super.key,
  });

  @override
  State<PickedAgencyAttachmentWidget> createState() =>
      _PickedAgencyAttachmentWidgetState();
}

class _PickedAgencyAttachmentWidgetState
    extends State<PickedAgencyAttachmentWidget> {
  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = context.read<ProfileCubit>();

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            profileCubit.pickAgencyAttachment().then((val) {
              setState(() {});
            });
          },
          child: TextFormFieldWithTitleWidget(
            validator: (value) {
              if (profileCubit.agencyAttachment == null) {
                return 'إرفاق الوكالة مطلوب';
              }
              return null;
            },
            title: profileCubit.agencyAttachment == null
                ? 'مرفق الوكالة'
                : profileCubit.agencyAttachment!.path.split('/').last,
            hint: 'مرفق الوكالة',
            hintStyle: AppStyles.styleBold16(context),
            filled: true,
            fillColor: AppColors.backgroundPrimary(context),
            enabled: false,
            keyboardType: TextInputType.number,
            prefix: SvgPicture.asset(
              AppAssets.app_imagesDocumentUpload,
              fit: BoxFit.fill,
              height: 32.h,
              width: 32.w,
            ),
          ),
        );
      },
    );
  }
}
