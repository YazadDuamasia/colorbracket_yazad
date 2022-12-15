import 'dart:async';
import 'dart:math';

import 'package:colorbracket_yazad/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../../routing/routs.dart';
import '../../utlis/utlis.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Size? size;
  Orientation? orientation;
  AnimationController? _animationController;
  bool? isDarkTheme;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController!.repeat(reverse: true);
    getPreferences();
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      Constants.isFirstTime("isFirst1").then((isFirstTime) {
        Constants.debugLog(SplashScreen, "isFirstTime:$isFirstTime");
        if (isFirstTime == true) {
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
            RouteName.loginRoute,
            arguments: true,
            (route) => false,
          );
        } else {
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
            RouteName.loginRoute,
            arguments: false,
            (route) => false,
          );
        }
      });
      // Navigator.pushNamedAndRemoveUntil(RouteName.loginRoute,(route) => false,);
      // navigatorKey.currentState!.pushNamedAndRemoveUntil(
      //   RouteName.loginRoute,
      //   (route) => false,
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    orientation = MediaQuery.of(context).orientation;
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: false);
    if (isDarkTheme != null && isDarkTheme == true) {
      theme.changeTheme();
    }
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return AnimateGradient(
              primaryBegin: Alignment.topLeft,
              primaryEnd: Alignment.bottomLeft,
              secondaryBegin: Alignment.bottomLeft,
              secondaryEnd: Alignment.topRight,
              duration: const Duration(seconds: 2),
              primaryColors: const [
                Color.fromRGBO(225, 109, 245, 1),
                Color.fromRGBO(78, 248, 231, 1),
                // Color.fromRGBO(99, 251, 215, 1),
                // Color.fromRGBO(83, 138, 214, 1)
              ],
              secondaryColors: const [
                Color.fromRGBO(5, 222, 250, 1),
                Color.fromRGBO(134, 231, 214, 1)
              ],
              child: SizedBox(
                key: UniqueKey(),
                width: size!.width,
                height: size!.height,
                child: Stack(
                  children: [
                    CircularParticle(
                      // key: UniqueKey(),
                      awayRadius: 80,
                      numberOfParticles: 100,
                      speedOfParticles: 1.3,
                      width: size!.width,
                      height: size!.height,
                      onTapAnimation: true,
                      particleColor: Colors.white.withAlpha(150),
                      awayAnimationDuration: const Duration(milliseconds: 600),
                      maxParticleSize: 8,
                      isRandSize: true,
                      isRandomColor: true,
                      randColorList:  [
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        Color(Random().nextInt(0xffffffff)).withAlpha(0xff),
                        // Colors.white,
                        // Colors.teal,
                        // Colors.blueAccent,
                        // Colors.redAccent
                      ],
                      awayAnimationCurve: Curves.easeInOutBack,
                      enableHover: true,
                      hoverColor: Colors.white,
                      hoverRadius: 90,
                      connectDots: false, //not recommended
                    ),
                    Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: FadeTransition(
                          opacity: _animationController!,
                          child: const Card(
                            elevation: 2,
                            color: Colors.white,
                            child: FlutterLogo(
                              size: 150,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  getPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isDarkTheme = preferences.getBool(Constants.prefThemeModeKey);
    setState(() {});
  }
}
