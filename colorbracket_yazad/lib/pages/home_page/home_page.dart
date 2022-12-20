import 'package:colorbracket_yazad/bloc/bloc.dart';
import 'package:colorbracket_yazad/main.dart';
import 'package:colorbracket_yazad/pages/pages.dart';
import 'package:colorbracket_yazad/routing/routs.dart';
import 'package:colorbracket_yazad/utlis/utlis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Size? size;
  Orientation? orientation;
  HomeScreenCubit? _homeScreenCubit;
  ThemeCubit? _themeCubit;
  bool isThemeDark = false;

  var brightness;

  @override
  void initState() {
    super.initState();
    var window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged = () {
      WidgetsBinding.instance.handlePlatformBrightnessChanged();
      // This callback is called every time the brightness changes.
      brightness = window.platformBrightness;
    };
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    orientation = MediaQuery.of(context).orientation;
    _homeScreenCubit = BlocProvider.of<HomeScreenCubit>(
      context,
      listen: false,
    );

    _themeCubit = BlocProvider.of<ThemeCubit>(
      context,
      listen: true,
    );

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text(
              "Home",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              FlutterSwitch(
                toggleSize: 45.0,
                value: Theme.of(context).brightness == Brightness.light
                    ? true
                    : false,
                borderRadius: 30.0,
                padding: 2.0,
                activeToggleColor: const Color(0xFF6E40C9),
                inactiveToggleColor: const Color(0xFF2F363D),
                activeSwitchBorder: Border.all(
                  color: const Color(0xFF3C1E70),
                  width: 6.0,
                ),
                inactiveSwitchBorder: Border.all(
                  color: const Color(0xFFD1D5DA),
                  width: 6.0,
                ),
                activeColor: const Color(0xFF271052),
                inactiveColor: Colors.white,
                activeIcon: const Icon(
                  Icons.nightlight_round,
                  color: Color(0xFFF8E3A1),
                ),
                inactiveIcon: const Icon(
                  Icons.wb_sunny,
                  color: Color(0xFFFFDF5D),
                ),
                onToggle: (val) async {
                  context.read<ThemeCubit>().toggleTheme(
                      Theme.of(context).brightness == Brightness.light
                          ? true
                          : false);
                },
              ),
            ],
            leadingWidth: 35,
            automaticallyImplyLeading: false,
          ),
          body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (context, state) {
              if (state is HomeScreenNoInternetState) {
                return ErrorPage(
                  errorMsg: "No Internet Connection",
                  onPressedRetryButton: () {
                    _homeScreenCubit!.getHomeScreenList();
                  },
                );
              }
              if (state is HomeScreenLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 3),
                );
              }
              if (state is HomeScreenErrorState) {
                Constants.debugLog(HomePage, "Error:${state.error}");
                return ErrorPage(
                  errorMsg: state.error,
                  onPressedRetryButton: () {
                    _homeScreenCubit!.getHomeScreenList();
                  },
                );
              }
              if (state is HomeScreenLoadedState) {
                return SizedBox(
                  width: size!.width,
                  height: size!.height,
                  child: Theme(
                    data: Theme.of(context),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _homeScreenCubit!.getHomeScreenList();
                      },
                      color: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).cardColor,
                      child: SingleChildScrollView(
                        primary: true,
                        clipBehavior: Clip.none,
                        physics: const ClampingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          addAutomaticKeepAlives: false,
                          cacheExtent: 10,
                          itemCount: state.list.isEmpty ? 0 : state.list.length,
                          itemBuilder: (context, index) {
                            var model = state.list[index];
                            return Card(
                              margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10.0),
                                onTap: () async {
                                  onItemClick(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Name: ${model.name ?? ""}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Designation: ${model.designation ?? ""}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Company: ${model.company ?? ""}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.end,
                                      //   crossAxisAlignment:
                                      //       CrossAxisAlignment.center,
                                      //   children: [
                                      //     TextButton(
                                      //       child: Text("View More"),
                                      //       onPressed: () async {
                                      //         onItemClick(index);
                                      //       },
                                      //       style: TextButton.styleFrom(
                                      //       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }
              return ErrorPage(
                errorMsg: "Something is wrong",
                onPressedRetryButton: () {
                  _homeScreenCubit!.getHomeScreenList();
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onItemClick(int index) async {
    await navigatorKey.currentState!
        .pushNamed(RouteName.viewMoreEmployeeScreenRoute, arguments: index + 1);
  }
}
