import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_vectors.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/pages/onboarding/onboarding_cubit.dart';
import 'package:tasky/ui/pages/onboarding/widgets/onboarding_background.dart';
import 'package:tasky/ui/pages/onboarding/widgets/onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return OnboardingCubit();
      },
      child: const OnboardingChildPage(),
    );
  }
}

class OnboardingChildPage extends StatefulWidget {
  const OnboardingChildPage({Key? key}) : super(key: key);

  @override
  State<OnboardingChildPage> createState() => _OnboardingChildPageState();
}

class _OnboardingChildPageState extends State<OnboardingChildPage> {
  late final OnboardingCubit _cubit;
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_controller.page == 1) {
          _cubit.changingPage(
            page: 0,
            controller: _controller,
          );
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: listPage,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 36),
          child: BlocBuilder<OnboardingCubit, OnboardingState>(
              buildWhen: (previous, current) =>
                  previous.currentPage != current.currentPage,
              builder: (context, state) {
                return AnimatedSmoothIndicator(
                  activeIndex: state.currentPage,
                  count: listPage.length,
                  onDotClicked: (value) {
                    _cubit.changingPage(
                      controller: _controller,
                      page: value,
                    );
                  },
                  duration: const Duration(milliseconds: 100),
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.primary,
                    dotColor: AppColors.dotColor,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget buildOnboardingScreen({
    required String vector,
    required Function() onPressed,
    required String title,
    required String description,
    required String buttonTitle,
  }) {
    return Stack(
      children: [
        OnboardingBackground(vector: vector),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: OnboardingContent(
            onPressed: onPressed,
            title: title,
            description: description,
            buttonTitle: buttonTitle,
          ),
        )
      ],
    );
  }

  List<Widget> get listPage {
    return [
      buildOnboardingScreen(
        vector: AppVectors.icManageYourActivity,
        onPressed: () {
          _cubit.changingPage(
            page: 1,
            controller: _controller,
          );
        },
        title: S.current.manageYourActivity,
        description: S.current.manageYourActivityDescription,
        buttonTitle: S.current.next,
      ),
      buildOnboardingScreen(
        vector: AppVectors.icSaveTheTime,
        onPressed: () {},
        title: S.current.saveTheTime,
        description: S.current.saveTheTimeDescription,
        buttonTitle: S.current.getStarted,
      ),
    ];
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
