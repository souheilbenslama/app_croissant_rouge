import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'ar_AE.dart';
import 'fr_FR.dart';

class LocalizationService extends Translations {
  static final locale = Locale('fr', 'FR');
  static final fallBackLocale = Locale('fr', 'FR');

  static final langs = ['Francais', 'Arabe'];
  static final locales = [Locale('fr', 'FR'), Locale('ar', 'AE')];

  @override
  Map<String, Map<String, String>> get keys => {
        'fr_FR': frFR,
        'ar_AE': arAE,
      };

  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    Get.updateLocale(locale);
  }

  Locale getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
