import 'package:shared_preferences/shared_preferences.dart';
import 'package:textile/app.dart';
import 'package:flutter/material.dart';
import 'package:textile/constants/app_constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initializing [kSharedPreferences]
  kSharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}
