import 'package:falak/core/utils/media_query_values.dart';
import 'package:falak/core/widgets/app_buttons.dart';
import 'package:falak/features/auth/presentation/view/widgets/steps_widget.dart';
import 'package:falak/features/profile/presentation/view/widgets/change_password/change_password_bottom_sheet.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:falak/core/utils/app_colors.dart';
import 'package:falak/core/widgets/coustom_app_bar_widget.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/widgets/my_snackbar.dart';
import '../../../view_model/pages_cubit.dart';
import '../../widgets/sales_agent/build_step_one.dart';
import '../../widgets/sales_agent/build_step_three.dart';
import '../../widgets/sales_agent/build_step_two.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentPage;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final PagesCubit pagesCubit;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentPage,
    required this.onPrevious,
    required this.onNext,
    required this.pagesCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        currentPage == 0
            ? SizedBox.shrink()
            : Expanded(
                flex: 2,
                child: AppOutlinedButton(onPressed: onPrevious, text: 'السابق'),
              ),
        8.horizontalSpace,
        Expanded(
          flex: 5,
          child: BlocConsumer<PagesCubit, PagesState>(
            listenWhen: (previous, current) =>
                previous.createSalesAgentRequestState !=
                current.createSalesAgentRequestState,
            listener: (context, state) {
              if (state.createSalesAgentRequestState == RequestState.loaded) {
                context.pop();
                context.pop();
                showModalBottomSheet(
                  isDismissible: false,
                  isScrollControlled: true,
                  enableDrag: false,
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) => Builder(
                    builder: (context) {
                      return ChangePasswordBottomSheet(
                        height: 300.h,
                        title: '',
                        subText: 'تم إرسال الطلب بنجاح',
                        subSubText: 'سيتم التواصل معك قريبا جداً.........',
                        haveImage: true,
                        haveButton: false,
                        image: Assets.appImagesIllustrations,
                        action: () {
                          context.pop();
                        },
                      );
                    }
                  ),
                );
              } else if (state.createSalesAgentRequestState ==
                  RequestState.error) {
                mySnackBar(
                  state.createSalesAgentError?.message ??
                      'هناك شئ ما خطأ حاول مجددا',
                  context,
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              return AppPrimaryButton(
                isLoading:
                    state.createSalesAgentRequestState == RequestState.loading,
                onPressed: onNext,
                text: currentPage == 2 ? 'إرسال الطلب' : 'التالي',
              );
            },
          ),
        ),
      ],
    );
  }
}

class AddSalesAgentScreen extends StatefulWidget {
  const AddSalesAgentScreen({super.key});

  @override
  State<AddSalesAgentScreen> createState() => _AddSalesAgentScreenState();
}

class _AddSalesAgentScreenState extends State<AddSalesAgentScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late PagesCubit pagesCubit;

  @override
  void initState() {
    pagesCubit = context.read<PagesCubit>();
    super.initState();
  }

  void _onNext() {
    if (_currentPage == 0) {
      if (!pagesCubit.companyDataFormKey.currentState!.validate()) {
        return;
      }
      if (pagesCubit.commercialRegStartDateController.text.isNotEmpty &&
          pagesCubit.commercialRegEndDateController.text.isNotEmpty) {
        DateTime startDate = DateTime.parse(
          pagesCubit.commercialRegStartDateController.text,
        );
        DateTime endDate = DateTime.parse(
          pagesCubit.commercialRegEndDateController.text,
        );

        if (!endDate.isAfter(startDate)) {
          FloatingSnackBar.show(
            context,
            'يجب أن يكون تاريخ الانتهاء بعد تاريخ الإصدار',
          );
          return;
        }
      }
    }

    if (_currentPage == 1 &&
        !pagesCubit.bankDateFormKey.currentState!.validate())
      return;
    if (_currentPage == 2 &&
        !pagesCubit.UserDataFormKey.currentState!.validate())
      return;
    if (_currentPage < 2) {
      setState(() {
        _currentPage++;
      });
      _pageController.jumpToPage(_currentPage);
    }
  }

  void _onPrevious() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.jumpToPage(_currentPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarySurface(context),
      appBar: CoustomAppBarWidget(
        title: [
          'بيانات الشركة',
          'البيانات المالية',
          'بيانات المفوض',
        ][_currentPage],
        actions: [
          StepsWidget(currentStep: _currentPage, totalSteps: 3),
          8.horizontalSpace,
        ],
      ),
      body: BlocBuilder<PagesCubit, PagesState>(
        builder: (context, state) {
          return PageView.builder(
            allowImplicitScrolling: false,
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: 3,
            itemBuilder: (context, index) => ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              children: [
                index == 0
                    ? BuildStepOneWidget()
                    : index == 1
                    ? BuildStepTwoWidget()
                    : BuildStepThreeWidget(),
                32.verticalSpace,
                CustomBottomNavigationBar(
                  currentPage: _currentPage,
                  onPrevious: _onPrevious,
                  onNext: () {
                    if (_currentPage == 2) {
                      if (!pagesCubit.isTermsAccepted) {
                        mySnackBar(
                          'يجب الموافقة على الشروط والاحكام للمتابعة',
                          context,
                          isError: true,
                        );
                        return;
                      }
                      pagesCubit.createSalesAgent();
                    } else {
                      _onNext();
                    }
                  },
                  pagesCubit: pagesCubit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
