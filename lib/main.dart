import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'Routers/app_route_config.dart';
import 'core/constant/global.dart';
import 'core/theme/themes_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  runApp(MyApp(router: MyAppRouter().router));
}

class MyApp extends StatefulWidget {
  final GoRouter router;

  const MyApp({required this.router, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp.router(
        theme: ToggleThemeData.lightTheme,
        title: 'Zecruiters RMS',
        debugShowCheckedModeBanner: false,
        routerConfig: widget.router,
      ),
    );
  }
}
