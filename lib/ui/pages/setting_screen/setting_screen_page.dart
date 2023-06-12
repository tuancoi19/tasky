import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasky/blocs/app_cubit.dart';
import 'package:tasky/common/app_colors.dart';
import 'package:tasky/common/app_text_styles.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';
import 'package:tasky/ui/widgets/appbar/app_bar_with_back_icon_widget.dart';

class SettingScreenPage extends StatelessWidget {
  const SettingScreenPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AppCubit();
      },
      child: const SettingScreenChildPage(),
    );
  }
}

class SettingScreenChildPage extends StatefulWidget {
  const SettingScreenChildPage({Key? key}) : super(key: key);

  @override
  State<SettingScreenChildPage> createState() => _SettingScreenChildPageState();
}

class _SettingScreenChildPageState extends State<SettingScreenChildPage> {
  late final AppCubit _cubit;
  bool needReload = false;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: needReload);
        return false;
      },
      child: Scaffold(
        appBar: AppBarWithBackIconWidget(
          onTap: () {
            Get.back(result: needReload);
          },
        ),
        body: SafeArea(
          child: _buildBodyWidget(),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32).r,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.language,
                    style: AppTextStyle.blackS15W500,
                  ),
                  buildDropDownButton(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildDropDownButton() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return DropdownButton<String>(
          value: state.locale.languageCode,
          underline: Container(
            height: 1.h,
            color: AppColors.primary,
          ),
          onChanged: (value) async {
            needReload = true;
            await _cubit.setLocale(locale: value ?? '');
          },
          items: AppConfigs.localList.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: AppTextStyle.blackO40S14W400,
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
