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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // Bloc.observer = SimpleBlocObserver();
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
  // runApp(
  //   const MyApp(),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dumasia Shop',
      home: MultiBlocProvider(
        providers: blocProviders,
        child: MaterialApp(
          title: 'Dumasia Shop',
          restorationScopeId: 'app',
          navigatorKey: navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: RouteName.loginRoute,
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          theme: ThemeData(
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
          ),
          darkTheme: ThemeData(
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
          ),
          themeMode: ThemeCubit().isDark ? ThemeMode.dark : ThemeMode.light,
        ),
      ),
    );
  }
}
