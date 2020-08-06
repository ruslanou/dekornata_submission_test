import 'package:dekornata_submission_test/utils/dekornata_routes.dart';
import 'package:dekornata_submission_test/utils/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/base/page_base.dart';
import 'pages/base/page_container.dart';

final RouteObserver<Route> routeObserver = RouteObserver<Route>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    var _theme = ThemeData(
      backgroundColor: AppColors.background,
      textTheme: Theme.of(context).textTheme.apply(
        bodyColor: AppColors.displayTextColor,
        displayColor: AppColors.displayTextColor,
      ),
      primaryTextTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.displayTextColor,
            displayColor: AppColors.displayTextColor,
          ),
      accentTextTheme: Theme.of(context).textTheme.apply(
        bodyColor: AppColors.accentTextColor,
        displayColor: AppColors.accentTextColor,
      ),
      primaryColor: AppColors.primary,
      accentColor: AppColors.accent,
      primaryIconTheme: Theme.of(context).iconTheme.copyWith(
        color: AppColors.displayTextColor,
      ),
      buttonColor: Colors.black54,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _theme,
      routes: {
        DekornataRoutes.catalogPage: (context) =>
            PageContainer(pageType: PageType.Catalog),
        DekornataRoutes.cartPage: (context) =>
            PageContainer(pageType: PageType.Cart),
        DekornataRoutes.userSettingsPage: (context) =>
            PageContainer(pageType: PageType.Settings),
        DekornataRoutes.addProductFormPage: (context) =>
            PageContainer(pageType: PageType.AddProductForm),
      },
      navigatorObservers: [routeObserver],
    );
  }
}