import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/ui/pages/user_profile/widgets/setting_options_list.dart';
import 'package:tasky/ui/pages/user_profile/widgets/user_profile_card.dart';

import 'user_profile_cubit.dart';

// class UserProfileArguments {
//   String param;
//
//   UserProfileArguments({
//     required this.param,
//   });
// }

class UserProfilePage extends StatelessWidget {
  // final UserProfileArguments arguments;

  const UserProfilePage({
    Key? key,
    // required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppCubit appCubit = BlocProvider.of<AppCubit>(context);

    return BlocProvider(
      create: (context) {
        return UserProfileCubit(appCubit: appCubit);
      },
      child: const UserProfileChildPage(),
    );
  }
}

class UserProfileChildPage extends StatefulWidget {
  const UserProfileChildPage({Key? key}) : super(key: key);

  @override
  State<UserProfileChildPage> createState() => _UserProfileChildPageState();
}

class _UserProfileChildPageState extends State<UserProfileChildPage> {
  late final UserProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return ListView(
      padding: const EdgeInsets.only(top: 36).r,
      physics: const ClampingScrollPhysics(),
      children: [
        UserProfileCard(
          displayName: 'Loren Ipsum',
          isVip: true,
          onTap: () {},
        ),
        SizedBox(height: 36.h),
        const SettingOptionsList(),
      ],
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
