import 'package:colorbracket_yazad/bloc/bloc.dart';
import 'package:colorbracket_yazad/bloc/theme_cubit/theme_state.dart';
import 'package:colorbracket_yazad/bloc_providers.dart';
import 'package:colorbracket_yazad/routing/routs.dart';
import 'package:colorbracket_yazad/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/config.dart';


final bucketGlobal = PageStorageBucket();

final GlobalKey<NavigatorState> navigatorKey =
GlobalKey<NavigatorState>(debugLabel: "navigatorKey");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // Bloc.observer = SimpleBlocObserver();
  BlocOverrides.runZoned(
        () => runApp(MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: "Yazad",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: AppColor.lightColorScheme,
              fontFamily: "Sono",
              appBarTheme: AppBarTheme(
                centerTitle: false,
                backgroundColor: AppColor.lightColorScheme.primary,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: AppColor.darkColorScheme,
              fontFamily: "Sono",
              appBarTheme: AppBarTheme(
                centerTitle: false,
                backgroundColor: AppColor.darkColorScheme.primary,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              brightness: Brightness.dark,
            ),
            themeMode: state.themeMode,
            restorationScopeId: 'app',
            navigatorKey: navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: RouteName.splashRoute,
            useInheritedMediaQuery: true,
          );
        },
      ),
    );
  }
}
