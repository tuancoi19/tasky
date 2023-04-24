import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/ui/pages/main_screen/widgets/main_screen_bottom_navigator_bar.dart';

import 'main_screen_cubit.dart';

// class MainScreenArguments {
//   String param;
//
//   MainScreenArguments({
//     required this.param,
//   });
// }

class MainScreenPage extends StatelessWidget {
  // final MainScreenArguments arguments;

  const MainScreenPage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MainScreenCubit();
      },
      child: const MainScreenChildPage(),
    );
  }
}

class MainScreenChildPage extends StatefulWidget {
  const MainScreenChildPage({Key? key}) : super(key: key);

  @override
  State<MainScreenChildPage> createState() => _MainScreenChildPageState();
}

class _MainScreenChildPageState extends State<MainScreenChildPage> {
  late final MainScreenCubit _cubit;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: _buildBodyWidget(),
          ),
          bottomNavigationBar: MainScreenBottomNavigatorBar(
            currentIndex: state.currentPage,
            onPageChange: (page) {
              _cubit.setCurrentPage(page);
              _pageController.animateToPage(
                page,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBodyWidget() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        _cubit.setCurrentPage(index);
      },
      children: AppConfigs.mainScreenPageList,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _cubit.close();
    super.dispose();
  }
}
