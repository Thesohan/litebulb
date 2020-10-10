import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/app_config.dart';
import 'package:new_artist_project/start_app.dart';

/// main file for production
/// This file used as the entry point of application when building for
/// production using the -t options.
///
/// Example: flutter build -t lib/main_prod.dart

void main() {
  AppConfig.init(AppFlavor.production);
  FlutterError.onError = (error) {};

  startApp();
}
