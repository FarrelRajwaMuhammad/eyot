import 'package:eyot/components/splash_screen.dart';
import 'package:eyot/core/helper/navigator_helper.dart';
import 'package:eyot/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class Dependency implements Bindings {
  @override
  void dependencies() {}
}

class InitApp extends StatelessWidget {
  InitApp({super.key});
  final NavigatorHelper navigatorHelper = NavigatorHelper();
  final SplashScreen splashScreen = SplashScreen();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Dependency(),
      debugShowCheckedModeBanner: false,
      builder: (context, child) => MediaQuery(
        child: child!,
        data: MediaQuery.of(context).copyWith(
          devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
          textScaler: TextScaler.linear(1.0),
        ),
      ),
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          bottomAppBarTheme: BottomAppBarTheme(
              elevation: 0.0,
              padding: EdgeInsets.only(
                top: 10,
              ))),
      getPages: [
        GetPage(name: navigatorHelper.root, page: () => MyApp()),
      ],
      home: SplashScreen(),
    );
  }
}
