import 'dart:async';
import 'dart:developer';
import 'dart:io' as ptf;
import 'dart:math' as math;

import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String prefThemeModeKey = "user_theme";

  ///print log at platform  level
  static void debugLog(Type? classObject, String? message) {
    try {
      var runtimeTypeName = (classObject).toString();
      if (kDebugMode) {
        // print("${runtimeTypeName.toString()}: $message");
        log("${runtimeTypeName.toString()}: $message");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  /*
  * * Usage
  * * Constants.debugLog(SplashScreen,"Hello");
  *
  */

  static Future<bool> isFirstTime(String? str) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime;
    try {
      isFirstTime = prefs.getBool(str ?? "CommonFirstTime") ?? true;
    } on Exception {
      isFirstTime = true;
    }
    await prefs.setBool(str ?? "CommonFirstTime", false);
    return isFirstTime;
  }

/*
  //Usage
  Constants.isFirstTime("ConstantUniqueKey").then((isFirstTime) {
  if(isFirstTime==true){
  print("First time");
  }else{
  print("Not first time");
  }
  });
  */

  static bool isDesktopOS() {
    return ptf.Platform.isMacOS ||
        ptf.Platform.isLinux ||
        ptf.Platform.isWindows;
  }

  static bool isAppOS() {
    return ptf.Platform.isIOS || ptf.Platform.isAndroid;
  }

  static bool isAndroid() {
    return ptf.Platform.isAndroid;
  }

  static bool isIOS() {
    return ptf.Platform.isIOS;
  }

  static bool isMacOS() {
    return ptf.Platform.isMacOS;
  }

  static bool isWeb() {
    return kIsWeb;
  }

  static Future<String> currentPlatform() async {
    var platformName = '';
    if (kIsWeb) {
      platformName = "Web";
    } else {
      if (ptf.Platform.isAndroid) {
        platformName = "android";
      } else if (ptf.Platform.isIOS) {
        platformName = "ios";
      } else if (ptf.Platform.isFuchsia) {
        platformName = "fuchsia";
      } else if (ptf.Platform.isLinux) {
        platformName = "linux";
      } else if (ptf.Platform.isMacOS) {
        platformName = "macos";
      } else if (ptf.Platform.isWindows) {
        platformName = "windows";
      }
    }
    // print("platformName :- " + platformName.toString());
    return platformName;
  }

  static int? randomNumberGenerator(int? min, int? max) {
    int? randomise = min! + math.Random().nextInt(max! - min);
    Constants.debugLog(Constants, "randomNumberMinMax:$randomise");
    if (randomise >= min && randomise <= max) {
      return randomise;
    } else {
      return randomNumberGenerator(min, max);
    }
  }

  static Map<String, dynamic>? responseCallBack(
      {required bool isError, required dynamic response}) {
    return {"isError": isError, "response": response};
  }
}
