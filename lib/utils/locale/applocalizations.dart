import 'package:blueberry/utils/locale/base_language.dart';
import 'package:blueberry/utils/locale/language_en.dart';
import 'package:blueberry/utils/locale/language_vi.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AppLocalizations extends LocalizationsDelegate<Languages> {
  const AppLocalizations();

  @override
  Future<Languages> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'vi':
        return LanguageVi();

      default:
        return LanguageEn();
    }
  }

  @override
  bool isSupported(Locale locale) => LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
