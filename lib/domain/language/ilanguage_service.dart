import 'package:flutter/material.dart';

abstract interface class ILanguageService  extends ChangeNotifier{
  Locale get currentLocale;
  void changeLanguage(String languageCode);
}
