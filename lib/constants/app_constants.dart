
import 'package:textile/l10n/app_localizations.dart';
import 'package:textile/models/models.dart';
import 'package:textile/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Name of application
const String kAppName = 'Textile Ordering System';

/// Instance/Object of shared pref to store data
late SharedPreferences kSharedPreferences;

/// Applications default font family
/// Overpass
const String kFontFamily = 'Overpass';

/// Instance of [AppLocalizations] to localize all the Strings used in application
AppLocalizations? kAppLocalizations;

/// Base scaffold provider
BaseScaffoldProvider? kBaseScaffoldProvider;

///
UserModel? kUserdata;

/// Class has member variables which is keys of shared preference
class PrefConst {
  /// shared pref key [userdata] where data of user is stored
  static const String userdata = 'userdata';

  /// shared pref key [username]
  static const String username = 'username';

  /// shared pref key [password]
  static const String password = 'password';

  /// shared pref key [shownSplashScreen] which tells whether
  /// the splash screen has displayed or not
  static const String shownSplashScreen = 'shown_splash_screen';

  /// shared pref key to store user token to authenticate user
  static const String userToken = 'user_token';

  /// shared pref key to store selected locale
  ///
  static const String locale = 'locale';
}
