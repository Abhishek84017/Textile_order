import 'package:textile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  /// Method to change locale
  set setLocale(Locale locale) {
    /// If there is no containing locale then return
    if (!AppLocalizations.delegate.isSupported(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}
