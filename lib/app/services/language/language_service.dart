import 'package:flickrate/app/services/local_storage/keys/keys.dart';
import 'package:flickrate/domain/language/ilanguage_service.dart';
import 'package:flickrate/domain/local_storage/ilocal_storage.dart';
import 'package:flutter/material.dart';

class LanguageService extends ChangeNotifier implements ILanguageService {
  final ILocalStorage _localStorage;

  Locale _currentLanguage = const Locale('en');

  @override
  Locale get currentLocale => _currentLanguage;

  LanguageService({required ILocalStorage localStorage})
      : _localStorage = localStorage {
    _init();
  }

  void _init() async {
    var key = await _localStorage.read(languageKey);
    if (key != null) {
      _currentLanguage = Locale(key);
      notifyListeners();
    }
  }

  @override
  void changeLanguage(String languageCode) {
    _currentLanguage = Locale(languageCode);
    _localStorage.save(languageKey, languageCode);
    notifyListeners();
  }
}
