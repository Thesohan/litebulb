import 'package:flutter/cupertino.dart';
import 'package:new_artist_project/app_config.dart';
import 'package:new_artist_project/data/cache/in_memory_cache/shared_pref_handler.dart';
import 'package:new_artist_project/start_app.dart';
import 'package:new_artist_project/util/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
//  TestWidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.init(AppFlavor.development);
  AppLogger.initLogger(true);

  FlutterError.onError = (error) {
    FlutterError.dumpErrorToConsole(error);
    print("### Error ###");
    print(error.stack);
  };

  startApp();
}
