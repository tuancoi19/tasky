import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasky/configs/app_configs.dart';
import 'package:tasky/generated/l10n.dart';

import 'blocs/app_cubit.dart';
import 'blocs/setting/app_setting_cubit.dart';
import 'common/app_themes.dart';
import 'router/route_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Setup PortraitUp only
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AppCubit>(create: (context) {
              return AppCubit();
            }),
            BlocProvider<AppSettingCubit>(create: (context) {
              return AppSettingCubit();
            }),
          ],
          child: BlocBuilder<AppSettingCubit, AppSettingState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  _hideKeyboard(context);
                },
                child: CalendarControllerProvider(
                  controller: EventController(),
                  child: GetMaterialApp(
                    title: AppConfigs.appName,
                    theme: AppThemes(
                      isDarkMode: false,
                      primaryColor: state.primaryColor,
                    ).theme,
                    // darkTheme: AppThemes(
                    //   isDarkMode: true,
                    //   primaryColor: state.primaryColor,
                    // ).theme,
                    themeMode: state.themeMode,
                    initialRoute: RouteConfig.splash,
                    getPages: RouteConfig.getPages,
                    localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      S.delegate,
                    ],
                    locale: state.locale,
                    supportedLocales: S.delegate.supportedLocales,
                    debugShowCheckedModeBanner: false,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
