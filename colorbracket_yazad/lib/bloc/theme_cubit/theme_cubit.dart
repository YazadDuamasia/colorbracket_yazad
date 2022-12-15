//
// class ThemeCubit extends Cubit<ThemeState> {
//   ThemeCubit() : super(ThemeState(themeMode: ThemeMode.light)) {
//     updateAppTheme();
//   }
//
//   void updateAppTheme() async{
//     final Brightness currentBrightness =
//         SchedulerBinding.instance.window.platformBrightness;
//     currentBrightness == Brightness.light
//         ? _setTheme(ThemeMode.light)
//         : _setTheme(ThemeMode.dark);
//   }
//
//   _setTheme(ThemeMode themeMode) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
//       systemNavigationBarIconBrightness:
//       themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
//       systemNavigationBarColor: themeMode == ThemeMode.light
//           ? AppColor.lightColorScheme.primary
//           : AppColor.darkColorScheme.primary,
//       systemNavigationBarDividerColor: Colors.transparent,
//     ));
//     emit(ThemeState(themeMode: themeMode));
//   }
// }
import 'package:colorbracket_yazad/bloc/theme_cubit/theme_state.dart';
import 'package:colorbracket_yazad/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  /// {@macro brightness_cubit}
  ThemeCubit() : super(ThemeState(theme: _lightTheme));

  static final _lightTheme = ThemeData(
    useMaterial3: true,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    colorScheme: AppColor.lightColorScheme,
    fontFamily: "Sono",
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: AppColor.lightColorScheme.primary,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: AppColor.darkColorScheme,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    fontFamily: "Sono",
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: AppColor.darkColorScheme.primary,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
  );

  /// Toggles the current brightness between light and dark.
  void toggleTheme() async {
    if (state.theme!.brightness == Brightness.dark) {
      emit(ThemeState(theme: _lightTheme));
    } else {
      emit(ThemeState(theme: _darkTheme));
    }
  }
}
