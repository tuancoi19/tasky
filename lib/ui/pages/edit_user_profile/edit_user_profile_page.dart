import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'edit_user_profile_cubit.dart';

class EditUserProfileArguments {
  String param;

  EditUserProfileArguments({
    required this.param,
  });
}

class EditUserProfilePage extends StatelessWidget {
  final EditUserProfileArguments arguments;

  const EditUserProfilePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return EditUserProfileCubit();
      },
      child: const EditUserProfileChildPage(),
    );
  }
}

class EditUserProfileChildPage extends StatefulWidget {
  const EditUserProfileChildPage({Key? key}) : super(key: key);

  @override
  State<EditUserProfileChildPage> createState() =>
      _EditUserProfileChildPageState();
}

class _EditUserProfileChildPageState extends State<EditUserProfileChildPage> {
  late final EditUserProfileCubit _cubit;

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
