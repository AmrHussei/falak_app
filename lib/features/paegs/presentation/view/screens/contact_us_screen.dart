import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/utils/app_styles.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/utils/images.dart';
import 'package:falak/core/widgets/coustom_app_bar_widget.dart';
import 'package:falak/features/paegs/presentation/view_model/pages_cubit.dart';

import '../../../../../core/functions/url_luncher.dart';
import '../../../../../core/widgets/error_app_widget.dart';
import '../widgets/contact_us/contact_us_card_widget.dart';
import '../widgets/contact_us/contact_us_form_widget.dart';
import '../widgets/contact_us/shimmer_contact_us.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    context.read<PagesCubit>().getSocial();
    context.read<PagesCubit>().getUserCashedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary(context),
      appBar: CoustomAppBarWidget(title: 'تواصل معنا'),
      body: Form(
        key: context.read<PagesCubit>().ContactFormKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.imagesContactUsIcon,
                    height: 156.h,
                    width: 156.w,
                  ),
                ],
              ),
              16.verticalSpace,
              Text(
                'نرحب بجميع استفساراتكم واقتراحاتكم، كما يسعدنا تلقي أي ملاحظات تودون مشاركتها معنا. آراؤكم تهمنا وتسهم في تطوير خدماتنا.',
                textAlign: TextAlign.center,
                style: AppStyles.styleRegular14(
                  context,
                ).copyWith(color: AppColors.grayText(context)),
              ),
              16.verticalSpace,
              Divider(),
              16.verticalSpace,
              BlocBuilder<PagesCubit, PagesState>(
                builder: (context, state) {
                  switch (state.getsocialRequestState) {
                    case RequestState.loading:
                    case RequestState.ideal:
                      return ShimmerContactUs();
                    case RequestState.error:
                      return ErrorAppWidget(
                        text: state.socialError!.message,
                        onTap: () {
                          context.read<PagesCubit>().getSocial();
                        },
                      );
                    case RequestState.loaded:
                      return Column(
                        children: [
                          ContactUsCardWidget(
                            text: 'إتصل بنا',
                            subText:
                                '${'966' + state.socialModel!.data!.phoneNumber!.number! + '+'}',
                            icon: AppAssets.app_imagesPhoneNum,
                            onTap: () {
                              String? phoneNumber =
                                  state.socialModel!.data!.phoneNumber!.key! +
                                  state.socialModel!.data!.phoneNumber!.number!;
                              callPhoneNumber(phoneNumber);
                            },
                          ),
                          16.verticalSpace,
                          ContactUsCardWidget(
                            text: 'المحادثة المباشرة',
                            icon: AppAssets.app_imagesWhatsapp,
                            subText:
                                '${'966' + state.socialModel!.data!.whatsapp!.number! + '+'}',
                            onTap: () {
                              String? whatsappNumber =
                                  state.socialModel!.data!.whatsapp!.key! +
                                  state.socialModel!.data!.whatsapp!.number!;
                              openLink('https://wa.me/${whatsappNumber}');
                            },
                          ),
                          16.verticalSpace,
                          ContactUsCardWidget(
                            text: 'البريد الالكتروني',
                            subText: '${state.socialModel!.data!.email}',
                            icon: AppAssets.app_imagesEmail,
                            onTap: () {
                              openEmail(email: state.socialModel!.data!.email);
                            },
                          ),
                          if ((state.socialModel?.data?.ourOffice ?? [])
                              .isNotEmpty) ...[
                            16.verticalSpace,

                            ContactUsCardWidget(
                              text: 'مكاتبنا',
                              icon: AppAssets.app_imagesOuroffice,
                              onTap: null,
                              offices: state.socialModel?.data?.ourOffice ?? [],
                            ),
                          ],

                          if (state.socialModel?.data != null) ...[
                            16.verticalSpace,

                            ContactUsCardWidget(
                              text: 'تابعنا على',
                              onTap: null,
                              links: {
                                Assets.appImagesX:
                                    state.socialModel!.data!.twitter,
                                Assets.appImagesLinkedin:
                                    state.socialModel!.data!.linkedin,
                                Assets.appImagesFacebook:
                                    state.socialModel!.data!.facebook,
                                Assets.appImagesTiktok:
                                    state.socialModel!.data!.tiktok,
                                Assets.appImagesInsta:
                                    state.socialModel!.data!.instagram,
                              },
                            ),
                          ],
                        ],
                      );
                  }
                },
              ),
              16.verticalSpace,
              Divider(),
              24.verticalSpace,
              Text(
                'راسلنا',
                textAlign: TextAlign.start,
                style: AppStyles.styleSemiBold16(
                  context,
                ).copyWith(color: AppColors.veryPrimaryColor(context)),
              ),
              8.verticalSpace,
              Divider(),
              16.verticalSpace,
              const ContactUsFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
