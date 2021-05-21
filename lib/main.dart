import 'package:app_croissant_rouge/lang/localization_service.dart';
import 'package:app_croissant_rouge/accidentProvider.dart';
import 'package:app_croissant_rouge/models/route_generator.dart';
import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/services/navigation_service.dart';
import 'package:app_croissant_rouge/services/socket_service.dart';
import 'package:app_croissant_rouge/views/screens/question_conscience.dart';
import 'package:app_croissant_rouge/views/screens/Profile.dart';
import 'package:app_croissant_rouge/views/screens/hemorragieExterneListe.dart';
import 'package:app_croissant_rouge/views/screens/listeMalaise.dart';
import 'package:app_croissant_rouge/views/screens/malaiseDiabetique.dart';
import 'package:app_croissant_rouge/views/screens/map_page.dart';
import 'package:app_croissant_rouge/views/screens/public_map.dart';
import 'package:app_croissant_rouge/views/screens/sign_in.dart';
import 'package:app_croissant_rouge/views/screens/testNotification.dart';
import 'package:app_croissant_rouge/views/screens/test_map.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:app_croissant_rouge/views/screens/test_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'locator.dart';
import 'views/screens/page_alerte.dart';
import 'package:app_croissant_rouge/views/screens/perte_connaissance_etapes.dart';
import 'package:app_croissant_rouge/views/screens/etouffement_oui.dart';
import 'package:app_croissant_rouge/views/screens/hemorex_oui.dart';
import 'package:app_croissant_rouge/views/screens/etouffement_non.dart';
import 'dart:convert' show json, base64, ascii;
import './views/screens/page_alerte.dart';
import 'package:app_croissant_rouge/views/screens/fracture.dart';
import 'package:app_croissant_rouge/views/screens/plaies_grave.dart';
import 'package:app_croissant_rouge/views/screens/plaies_simples.dart';
import 'package:app_croissant_rouge/views/screens/brulure_simple.dart';
import 'package:app_croissant_rouge/views/screens/brulure_grave.dart';
import 'package:app_croissant_rouge/views/screens/crise_nerfs.dart';
import 'package:app_croissant_rouge/views/screens/mal_cardio.dart';
import 'package:app_croissant_rouge/views/screens/mal_diab.dart';

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
    // TODO: implement initState
    super.initState();
    this.widget.locator = GetIt.instance;
    this.widget.locator.registerLazySingleton(() => NavigationService());
    WidgetsBinding.instance.addObserver(this);
  }
/*
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  } */

// tracking if the app is in background or foreground
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
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
      //home: MalCardio(),
      //home: MalDiab(),
    );
  }
}
