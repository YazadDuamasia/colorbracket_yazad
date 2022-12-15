import 'package:colorbracket_yazad/bloc/bloc.dart';
import 'package:colorbracket_yazad/config/app_config.dart';
import 'package:colorbracket_yazad/config/config.dart';
import 'package:colorbracket_yazad/pages/error_page/error_page.dart';
import 'package:colorbracket_yazad/utlis/utlis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Size? size;
  Orientation? orientation;
  HomeScreenCubit? _homeScreenCubit;
  bool isThemeDark = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    orientation = MediaQuery.of(context).orientation;
    _homeScreenCubit = BlocProvider.of<HomeScreenCubit>(
      context,
      listen: false,
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
                              margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10.0),
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,

                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(model.name ?? ""),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child:
                                                Text(model.designation ?? ""),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(model.company ?? ""),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            child: Text("View More"),
                                            onPressed: () async {},
                                            style: TextButton.styleFrom(
                                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                                            ),
                                          )
                                        ],
                                      ),
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
}
