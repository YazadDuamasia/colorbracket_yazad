import 'package:colorbracket_yazad/bloc/bloc.dart';
import 'package:colorbracket_yazad/routing/routs.dart';
import 'package:colorbracket_yazad/simple_bloc_observer.dart';
import 'package:colorbracket_yazad/bloc_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
}

class MyApp extends StatelessWidget {
  /// {@macro app}
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
            theme: state.theme,
            restorationScopeId: 'app',
            navigatorKey: navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: RouteName.loginRoute,
            useInheritedMediaQuery: true,
          );
        },
      ),
    );
  }
}


//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Dumasia Shop',
//       home: MultiBlocProvider(
//         providers: blocProviders,
//         child: StreamBuilder<bool>(
//
//             builder: (context, snapshot) {
//               return MaterialApp(
//                 title: 'Dumasia Shop',
//                 restorationScopeId: 'app',
//                 navigatorKey: navigatorKey,
//                 onGenerateRoute: RouteGenerator.generateRoute,
//                 initialRoute: RouteName.loginRoute,
//                 debugShowCheckedModeBanner: false,
//                 useInheritedMediaQuery: true,
//                 theme: ThemeData(
//                   useMaterial3: true,
//                   inputDecorationTheme: const InputDecorationTheme(
//                     border: OutlineInputBorder(),
//                   ),
//                   colorScheme: AppColor.lightColorScheme,
//                   fontFamily: "Sono",
//                   appBarTheme: AppBarTheme(
//                     centerTitle: false,
//                     backgroundColor: AppColor.lightColorScheme.primary,
//                   ),
//                   visualDensity: VisualDensity.adaptivePlatformDensity,
//                 ),
//                 darkTheme: ThemeData(
//                   useMaterial3: true,
//                   colorScheme: AppColor.darkColorScheme,
//                   inputDecorationTheme: const InputDecorationTheme(
//                     border: OutlineInputBorder(),
//                   ),
//                   fontFamily: "Sono",
//                   appBarTheme: AppBarTheme(
//                     centerTitle: false,
//                     backgroundColor: AppColor.darkColorScheme.primary,
//                   ),
//                   visualDensity: VisualDensity.adaptivePlatformDensity,
//                 ),
//                 themeMode:
//                     snapshot.data == false ? ThemeMode.dark : ThemeMode.light,
//               );
//             }),
//       ),
//     );
//   }
// }
