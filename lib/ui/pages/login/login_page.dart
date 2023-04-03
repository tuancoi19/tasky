import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/textfields/app_text_field.dart';

import 'login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginCubit();
      },
      child: const LoginChildPage(),
    );
  }
}

class LoginChildPage extends StatefulWidget {
  const LoginChildPage({Key? key}) : super(key: key);

  @override
  State<LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<LoginChildPage> {
  late final LoginCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      color: AppColors.authBackgroundColor,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 24),
        children: [
          Text(
            S.current.usernameOrEmail,
            style: AppTextStyle.blackS15W500,
          ),
          const SizedBox(height: 20),
           AppTextFieldWidget(hintText: S.current.enterYourUsernameOrEmail,),
          const SizedBox(height: 24),
          Text(
            S.current.password,
            style: AppTextStyle.blackS15W500,
          ),
          const SizedBox(height: 20),
           AppTextFieldWidget(hintText: S.of(context).enterYourPassword,),

        ],
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
