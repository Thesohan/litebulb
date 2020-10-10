enum AppFlavor { development, production }

/// Provides configuration depending on the flavor of build.
/// Any property app configuration that differs in prod and dev should be
/// added here.
class AppConfig {
  static AppFlavor _appFlavor;

  /// Initialise the flavor of the application
  /// Make sure this function is called no more than once
  /// throughout the application.
  static void init(AppFlavor flavor) {
    assert(flavor != null);
    if (_appFlavor != null) {
      throw Error();
    }
    _appFlavor = flavor;
  }

  static AppFlavor get appFlavor => _appFlavor;

  static String get baseUrl {
    switch (_appFlavor) {
      case AppFlavor.production:
        return "https://magicdrop.co.in/litebulb/index.php";
//      case AppFlavor.development:
      default:
        return "https://magicdrop.co.in/litebulb/index.php";
    }
  }

  /// Logs from networking interceptor should be printed
  /// in console.
  static bool get isNetworkLogEnabled {
    switch (_appFlavor) {
      case AppFlavor.production:
        return false;
      case AppFlavor.development:
      default:
        return true;
    }
  }
}
