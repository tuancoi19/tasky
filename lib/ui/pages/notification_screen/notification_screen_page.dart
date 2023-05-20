import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/ui/pages/notification_screen/widgets/notification_item.dart';
import 'package:tasky/ui/widgets/appbar/app_bar_with_back_icon_widget.dart';

import 'notification_screen_cubit.dart';

class NotificationScreenArguments {
  final bool isNotification;

  NotificationScreenArguments({
    required this.isNotification,
  });
}

class NotificationScreenPage extends StatelessWidget {
  final NotificationScreenArguments arguments;

  const NotificationScreenPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotificationScreenCubit();
      },
      child: NotificationScreenChildPage(
        canPop: arguments.isNotification,
      ),
    );
  }
}

class NotificationScreenChildPage extends StatefulWidget {
  final bool canPop;

  const NotificationScreenChildPage({Key? key, required this.canPop})
      : super(key: key);

  @override
  State<NotificationScreenChildPage> createState() =>
      _NotificationScreenChildPageState();
}

class _NotificationScreenChildPageState
    extends State<NotificationScreenChildPage> {
  late final NotificationScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.canPop ? const AppBarWithBackIconWidget() : null,
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return NotificationItem(
          title: 'Loren Ipsum',
          isCompleted: true,
          onTap: () {},
        );
      },
      itemCount: 5,
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
