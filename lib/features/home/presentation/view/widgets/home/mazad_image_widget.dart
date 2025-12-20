import 'dart:io';

import 'package:dio/dio.dart' show Dio, Options, ResponseType;
import 'package:falak/app/app.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/features/home/data/models/auctions_model/auctions_model.dart';
import 'package:falak/features/home/presentation/view/widgets/home/favorite_widget.dart';
import 'package:falak/features/home/presentation/view/widgets/home/mazad_title_and_location_widget.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class MazadImageWidget extends StatelessWidget {
  const MazadImageWidget({
    super.key,
    required this.model,
    required this.fromDetails,
  });

  final AuctionData model;
  final bool fromDetails;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 209.h,
          decoration: BoxDecoration(
            borderRadius: fromDetails
                ? null
                : BorderRadius.only(
              topLeft: Radius.circular(12.r),
              topRight: Radius.circular(12.r),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImageWidegt(
            imageUrl: model.cover ?? '',
            width: double.infinity,
            height: 209.h,
          ),
        ),
        PositionedDirectional(
          top: 10.h,
          end: 8.w,
          child: Container(
            height: 36.h,
            width: 88.w,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: AppColors.black(context),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                model.type == 'online'
                    ? 'مزاد الكتروني'
                    : model.type == 'hybrid'
                    ? 'مزاد هجين'
                    : 'مزاد حضوري',
                style: AppStyles.styleMedium12(
                  context,
                ).copyWith(color: AppColors.white(context)),
              ),
            ),
          ),
        ),
        if (!KisGuest)
          PositionedDirectional(
            top: 12.h,
            start: 10.w,
            child: FavoriteWidget(
              isFavorite: model.isFavorite == true,
              onTab: () {
                context.read<HomeCubit>().toggleFavoriteAuction(
                  model.id,
                  !(model.isFavorite ?? false),
                );
              },
            ),
          ),
        if (!KisGuest)
          PositionedDirectional(
            top: 8.h,
            start: 50.w,
            child: InkWell(
              onTap: () async {
                try {
                  final tempDir = await getTemporaryDirectory();

                  final imageUrl = model.cover;
                  if (imageUrl == null || imageUrl.isEmpty) return;

                  // Download image
                  final response = await Dio().get<List<int>>(
                    imageUrl,
                    options: Options(responseType: ResponseType.bytes),
                  );

                  // Save to temp file
                  final file = File('${tempDir.path}/shared_image.jpg');
                  await file.writeAsBytes(response.data!);

                  // ✅ SHARE (correct API)
                  await Share.shareXFiles(
                    [XFile(file.path)],
                    text:
                    '''
لا تفوتك فرصة المشاركة في مزاد ${model.title ?? ''}
عبر الرابط التالي
https://falak-website-lac.vercel.app/auctions/${model.id}
''',
                    subject: 'فلك الخير',
                  );
                } catch (e) {
                  debugPrint('Share error: $e');
                }
              },

              child: SvgPicture.asset(Assets.appImagesShare),
            ),
          ),
      ],
    );
  }
}
