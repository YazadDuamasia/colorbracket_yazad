import 'package:colorbracket_yazad/bloc/bloc.dart';
import 'package:colorbracket_yazad/pages/pages.dart';
import 'package:colorbracket_yazad/routing/routs.dart';
import 'package:colorbracket_yazad/utlis/utlis.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  /*
  *
  *  If want to pop all previous routes and move specific screen.
  *  Navigator.of(context).pushNamedAndRemoveUntil(RouteName.homeScreenRoute, (Route<dynamic> route) => false,);
  *
  */

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute<dynamic>(builder: (_) => const SplashScreen());

      case RouteName.splashRoute:
        return MaterialPageRoute<dynamic>(builder: (_) => const SplashScreen());

      case RouteName.loginRoute:
        Constants.debugLog(RouteGenerator, "isFirstTime:${settings.arguments}");
        return PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          settings: settings,
          curve: Curves.easeInOut,
          child: LoginScreen(isFirstTime: settings.arguments as bool),
        );

      case RouteName.homeScreenRoute:
        return PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          settings: settings,
          curve: Curves.easeInOut,
          child: HomePage(),
        );
      case RouteName.viewMoreEmployeeScreenRoute:
        Constants.debugLog(RouteGenerator, "arg:${ settings.arguments}");
        return PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          settings: settings,
          curve: Curves.easeInOut,
          child: ViewMoreEmployeePage(position: settings.arguments as int),
        );
        case RouteName.webViewScreenRoute:
        Constants.debugLog(RouteGenerator, "arg:${ settings.arguments}");
        return PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          settings: settings,
          curve: Curves.easeInOut,
          child: WebViewPage(webUrl: settings.arguments as String),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
