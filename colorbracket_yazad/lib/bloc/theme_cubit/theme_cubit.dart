
import 'package:colorbracket_yazad/bloc/theme_cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.light));
  //
  // static final _lightTheme = ThemeData(
  //   useMaterial3: true,
  //   inputDecorationTheme: const InputDecorationTheme(
  //     border: OutlineInputBorder(),
  //   ),
  //   colorScheme: AppColor.lightColorScheme,
  //   fontFamily: "Sono",
  //   appBarTheme: AppBarTheme(
  //     centerTitle: false,
  //     backgroundColor: AppColor.lightColorScheme.primary,
  //   ),
  //   visualDensity: VisualDensity.adaptivePlatformDensity,
  //   brightness: Brightness.light,
  // );
  //
  // static final _darkTheme = ThemeData(
  //   useMaterial3: true,
  //   colorScheme: AppColor.darkColorScheme,
  //   inputDecorationTheme: const InputDecorationTheme(
  //     border: OutlineInputBorder(),
  //   ),
  //   fontFamily: "Sono",
  //   appBarTheme: AppBarTheme(
  //     centerTitle: false,
  //     backgroundColor: AppColor.darkColorScheme.primary,
  //   ),
  //   visualDensity: VisualDensity.adaptivePlatformDensity,
  //   brightness: Brightness.dark,
  // );

  /// Toggles the current brightness between light and dark.
  void toggleTheme(bool? isDarkMode) async {
    if (isDarkMode==true) {
      emit(ThemeState(themeMode: ThemeMode.dark));
    } else{
      emit(ThemeState(themeMode: ThemeMode.light));
    }
  }
  void themeSelector() async {
    if (state.themeMode== ThemeMode.dark) {
      emit(ThemeState(themeMode: ThemeMode.light));
    } else if(state.themeMode== ThemeMode.light) {
      emit(ThemeState(themeMode: ThemeMode.dark));
    }else if(state.themeMode== ThemeMode.system){
      emit(ThemeState(themeMode: ThemeMode.system));
    }else{
      emit(ThemeState(themeMode: ThemeMode.light));
    }
  }
}
