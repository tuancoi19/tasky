import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'activity_cubit.dart';

class ActivityArguments {
  String param;

  ActivityArguments({
    required this.param,
  });
}

class ActivityPage extends StatelessWidget {
  final ActivityArguments arguments;

  const ActivityPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return ActivityCubit();
      },
      child: const ActivityChildPage(),
    );
  }
}

class ActivityChildPage extends StatefulWidget {
  const ActivityChildPage({Key? key}) : super(key: key);

  @override
  State<ActivityChildPage> createState() => _ActivityChildPageState();
}

class _ActivityChildPageState extends State<ActivityChildPage> {
  late final ActivityCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Container();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
