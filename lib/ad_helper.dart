import 'dart:io';

class AdHelper {
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-2455259266167881/5727897105";
    } else if (Platform.isIOS) {
      return "ca-app-pub-2455259266167881/5727897105";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-2455259266167881/7811134967";
    } else if (Platform.isIOS) {
      return "ca-app-pub-2455259266167881/7811134967";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
