import 'package:falak/core/utils/app_strings.dart';
import 'package:falak/core/widgets/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:falak/core/utils/enums.dart';
import 'package:falak/core/widgets/error_app_widget.dart';
import 'package:falak/features/home/presentation/view_model/home/home_cubit.dart';

import '../../../../../core/widgets/coustom_app_bar_widget.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen>
    with SingleTickerProviderStateMixin {
  static const _policyKeys = [
    AppStrings.policyPrivacy,
    AppStrings.policyRefund,
    AppStrings.policyIntellectual,
  ];

  static const _policyTabs = [
    'سياسة الخصوصية',
    'شروط الاستخدام',
    'سياسة الملكية الفكرية',
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _policyKeys.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().loadAllPolicies();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoustomAppBarWidget(title: 'الشروط و الاحكام'),
      body: Column(
        children: [
          CustomTabBar(
            controller: _tabController,
            haveWidth: false,
            tabs: _policyTabs,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _policyKeys
                  .map((policyKey) => PolicyTabContent(policyKey: policyKey))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class PolicyTabContent extends StatelessWidget {
  const PolicyTabContent({super.key, required this.policyKey});

  final String policyKey;

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.policiesRequestState != current.policiesRequestState ||
          previous.policiesModel != current.policiesModel ||
          previous.policiesError != current.policiesError,
      builder: (context, state) {
        final policyModel = state.policiesModel[policyKey];

        if (policyModel != null) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Html(
              data: policyModel.data.content,
              style: {
                "body": Style(
                  fontFamily: 'Lama Sans',
                  lineHeight: LineHeight(1.7),
                  fontSize: FontSize(16),
                ),
              },
            ),
          );
        }

        final requestState =
            state.policiesRequestState[policyKey] ?? RequestState.ideal;

        switch (requestState) {
          case RequestState.loading:
          case RequestState.ideal:
            return const ShimmerPolicyContent();
          case RequestState.loaded:
            return const ShimmerPolicyContent();
          case RequestState.error:
            return ErrorAppWidget(
              text: state.policiesError[policyKey]?.message ?? 'حدث شئ ما خطأ',
              onTap: () {
                homeCubit.getPolicy(policyKey, refresh: true);
              },
            );
        }
      },
    );
  }
}

class ShimmerPolicyContent extends StatelessWidget {
  const ShimmerPolicyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmerBox(height: 20, width: 200),
          const SizedBox(height: 16),
          _buildShimmerBox(height: 16, width: double.infinity),
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity),
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity),
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: 250),
          const SizedBox(height: 16),
          _buildShimmerBox(height: 16, width: double.infinity),
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity),
          const SizedBox(height: 16),
          _buildShimmerBox(height: 16, width: double.infinity),
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity),
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity),
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: 250),
          const SizedBox(height: 16),
          _buildShimmerBox(height: 16, width: double.infinity),
          const SizedBox(height: 8),
          _buildShimmerBox(height: 16, width: double.infinity),
        ],
      ),
    );
  }

  Widget _buildShimmerBox({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
