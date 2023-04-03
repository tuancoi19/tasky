import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'signin_cubit.dart';

class SigninPage extends StatelessWidget {

  const SigninPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SigninCubit();
      },
      child: const SigninChildPage(),
    );
  }
}

class SigninChildPage extends StatefulWidget {
  const SigninChildPage({Key? key}) : super(key: key);

  @override
  State<SigninChildPage> createState() => _SigninChildPageState();
}

class _SigninChildPageState extends State<SigninChildPage> {
  late final SigninCubit _cubit;

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
