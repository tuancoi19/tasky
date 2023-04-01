import 'package:flutter/material.dart';
import 'package:tasky/ui/pages/onboarding/widgets/onboarding_background.dart';
import 'package:tasky/ui/pages/onboarding/widgets/onboarding_content.dart';

class OnboardingPage extends StatelessWidget {
  final PageController backgroundController = PageController();
  final PageController contentController = PageController();

  OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (contentController.page == 1 && backgroundController.page == 1) {
          contentController.animateToPage(0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate);
          backgroundController.animateToPage(0,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate);
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
    return Stack(
      children: [
        OnboardingBackground(controller: backgroundController),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: OnboardingContent(
            controller: contentController,
            onPressed: () {
              contentController.animateToPage(1,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.decelerate);
              backgroundController.animateToPage(1,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.decelerate);
            },
            onDotsClicked: (value) {
              contentController.animateToPage(value,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.decelerate);
              backgroundController.animateToPage(value,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.decelerate);
            },
          ),
        )
      ],
    );
  }
}
