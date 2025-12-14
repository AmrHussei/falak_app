import 'package:falak/core/widgets/custom_tab_bar.dart';
import 'package:falak/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/widgets/coustom_app_bar_widget.dart';
import 'package:falak/core/widgets/empty_widget.dart';
import 'package:falak/features/paegs/presentation/view_model/pages_cubit.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/error_app_widget.dart';
import '../../../data/models/categories_model.dart';
import '../widgets/qustions/question_answer_widget.dart';
import '../widgets/qustions/qustion_search_filed.dart';
import '../widgets/qustions/shimmer_question_answer_list.dart';

class QustionScreen extends StatefulHookWidget {
  QustionScreen({super.key});

  @override
  State<QustionScreen> createState() => _QustionScreenState();
}

class _QustionScreenState extends State<QustionScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = context.read<PagesCubit>();
      cubit.getQestionsCategories().then((_) {
        cubit.getQuestions();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showSearch = useState(false);
    PagesCubit pagesCubit = context.read<PagesCubit>();
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary(context),
      appBar: CoustomAppBarWidget(
        title: ' الأسئلة الشائعة',
        titleWidget: showSearch.value ? QustionSearchFiled() : null,
        actions: [
          InkWell(
            onTap: () {
              showSearch.value = !showSearch.value;
            },
            child: Container(
              height: 42.h,
              width: 42.w,
              decoration: ShapeDecoration(
                color: const Color(0xFFFAFAFA) /* Surface-primary */,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: const Color(0xFFE1E1E2) /* Borders-primary */,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    showSearch.value
                        ? Assets.imagesClose
                        : Assets.imagesMagnifer,
                    fit: BoxFit.contain,
                    height: 18.h,
                    width: 18.w,
                  ),
                ],
              ),
            ),
          ),
          12.horizontalSpace,
        ],
      ),
      body: BlocListener<PagesCubit, PagesState>(
        listener: (context, state) {
          if (state.qestionsCategoriesRequestState == RequestState.loaded) {
            controller = TabController(
              length: state.qestionsCategoriesModel?.data.length ?? 0,
              vsync: this,
            );
            controller?.addListener(() {
              pagesCubit.getQuestions();
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<PagesCubit, PagesState>(
                buildWhen:
                    (previous, current) =>
                        previous.qestionsCategoriesRequestState !=
                        current.qestionsCategoriesRequestState,
                builder: (context, state) {
                  if (state.qestionsCategoriesModel != null) {
                    return HorizontalCategorySelector(
                      qestionsCategoriesModel: state.qestionsCategoriesModel!,
                      controller: controller,
                    );
                  }
                  switch (state.qestionsCategoriesRequestState) {
                    case RequestState.error:
                      return ErrorAppWidget(
                        text:
                            state.qestionsCategoriesError?.message ??
                            'حدث شئ ما خطأ',
                        onTap: () {
                          pagesCubit.getQestionsCategories();
                        },
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
              Expanded(
                child: BlocBuilder<PagesCubit, PagesState>(
                  builder: (context, state) {
                    final category = state.selectedCategory?.id ?? '';
                    final data = state.qestionsModel[category]?.data ?? [];
                    final status = state.qestionsRequestState[category];
                    if (data.isNotEmpty) {
                      return ListView.separated(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        separatorBuilder: (context, index) => 12.verticalSpace,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return QuestionAnswerWidget(model: data[index]);
                        },
                      );
                    }
                    switch (status) {
                      case RequestState.ideal:
                      case RequestState.loading:
                        return ShimmerQuestionAnswerList();
                      case RequestState.loaded:
                        return data.isEmpty
                            ? Center(
                              child: EmptyWidget(
                                title: 'لم يتم العثور على البحث',
                              ),
                            )
                            : const SizedBox.shrink();
                      default:
                        return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HorizontalCategorySelector extends StatelessWidget {
  const HorizontalCategorySelector({
    super.key,
    required this.qestionsCategoriesModel,
    this.controller,
  });

  final QestionsCategoriesModel qestionsCategoriesModel;
  final TabController? controller;

  @override
  Widget build(BuildContext context) {
    return controller != null
        ? CustomTabBar(
          haveWidth: false,
          onTap: (index) {
            context.read<PagesCubit>().changeCategory(
              qestionsCategoriesModel.data[index],
            );
          },
          controller: controller!,
          tabs: qestionsCategoriesModel.data.map((item) => item.name).toList(),
        )
        : const SizedBox.shrink();
  }
}
