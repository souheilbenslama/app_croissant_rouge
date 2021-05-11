import 'package:app_croissant_rouge/lang/localization_service.dart';
import 'package:app_croissant_rouge/accidentProvider.dart';
import 'package:app_croissant_rouge/models/route_generator.dart';
import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/services/navigation_service.dart';
import 'package:app_croissant_rouge/views/screens/Respiration.dart';
import 'package:app_croissant_rouge/views/screens/conscience2.dart';
import 'package:app_croissant_rouge/views/screens/Profile.dart';
import 'package:app_croissant_rouge/views/screens/map_page.dart';
import 'package:app_croissant_rouge/views/screens/public_map.dart';
import 'package:app_croissant_rouge/views/screens/sign_in.dart';
import 'package:app_croissant_rouge/views/screens/test_map.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:app_croissant_rouge/views/screens/test_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'locator.dart';
import 'views/screens/page_alerte.dart';
import 'package:app_croissant_rouge/views/screens/etapes.dart';
import 'dart:convert' show json, base64, ascii;
import './views/screens/page_alerte.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AccidentProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GetIt locator = GetIt.instance;

    locator.registerLazySingleton(() => NavigationService());

    return GetMaterialApp(
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      navigatorKey: locator<NavigationService>().navigatorKey,
      translations: LocalizationService(),
      locale: Locale('fr', 'FR'),
      fallbackLocale: Locale('fr', 'FR'),
      debugShowCheckedModeBanner: false,
      title: '',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: SignIn(),
      //home: MapPage()
      home: PageAlerte(),
      //home: TestNotification(),
      //home: Profile(ss),
      //home: Conscient()
    );
  }
}
