import 'package:app_croissant_rouge/lang/localization_service.dart';
import 'package:app_croissant_rouge/accidentProvider.dart';
import 'package:app_croissant_rouge/models/route_generator.dart';
import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:app_croissant_rouge/views/screens/Respiration.dart';
import 'package:app_croissant_rouge/views/screens/conscience2.dart';
import 'package:app_croissant_rouge/views/screens/Profile.dart';
import 'package:app_croissant_rouge/views/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'views/screens/page_alerte.dart';
import './views/screens/page_alerte.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AccidentProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
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
      //home: MapePage()
      home: PageAlerte(),
      //home: TestNotification(),
      //home: Profile(ss),
      //home: Conscient()
    );
  }
}
