import 'package:app_croissant_rouge/lang/localization_service.dart';
import 'package:app_croissant_rouge/accidentProvider.dart';
import 'package:app_croissant_rouge/models/route_generator.dart';

import 'package:app_croissant_rouge/services/navigation_service.dart';
import 'package:app_croissant_rouge/services/socket_service.dart';
import 'package:bot_toast/bot_toast.dart';

import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'locator.dart';
import 'views/screens/page_alerte.dart';
import './views/screens/page_alerte.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AccidentProvider(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  GetIt locator;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    this.widget.locator = GetIt.instance;
    this.widget.locator.registerLazySingleton(() => NavigationService());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

// tracking if the app is in background or foreground
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      SocketService.status = false;
    } else {
      SocketService.status = true;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      //home: ListeMalaise()
      //home: HemorexOui(),
      //home: Fracture(),
      //home: PlaiesGraves(),
      //home: PlaiesSimples(),
      //home: BrulureSimple(),
      //home: BrulureGrave(),
      // home: CriseNerfs(),
      // home: MalCardio(),
      //home: MalDiab(),
    );
  }
}
