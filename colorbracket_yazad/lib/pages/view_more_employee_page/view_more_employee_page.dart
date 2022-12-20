import 'package:colorbracket_yazad/bloc/bloc.dart';
import 'package:colorbracket_yazad/main.dart';
import 'package:colorbracket_yazad/pages/pages.dart';
import 'package:colorbracket_yazad/routing/routs.dart';
import 'package:colorbracket_yazad/utlis/utlis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewMoreEmployeePage extends StatefulWidget {
  int? position;

  ViewMoreEmployeePage({Key? key, required this.position}) : super(key: key);

  @override
  State<ViewMoreEmployeePage> createState() => _ViewMoreEmployeePageState();
}

class _ViewMoreEmployeePageState extends State<ViewMoreEmployeePage> {
  Size? size;
  Orientation? orientation;
  ViewMoreEmployeeCubit? _viewMoreEmployeeCubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    orientation = MediaQuery.of(context).orientation;
    _viewMoreEmployeeCubit = BlocProvider.of<ViewMoreEmployeeCubit>(
      context,
      listen: false,
    );
    _viewMoreEmployeeCubit!.getViewMoreEmployeeData(widget.position);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: false,
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon:const Icon(Icons.arrow_back_ios,color: Colors.white),
              //replace with our own icon data.
            ),
            leadingWidth: 35,
            automaticallyImplyLeading: false,
          ),
          body: BlocBuilder<ViewMoreEmployeeCubit, ViewMoreEmployeeState>(
            builder: (context, state) {
              if (state is ViewMoreEmployeeNoInternetState) {
                return ErrorPage(
                  errorMsg: "No Internet Connection",
                  onPressedRetryButton: () {
                    _viewMoreEmployeeCubit!
                        .getViewMoreEmployeeData(widget.position);
                  },
                );
              }
              if (state is ViewMoreEmployeeLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 3),
                );
              }
              if (state is ViewMoreEmployeeErrorState) {
                Constants.debugLog(HomePage, "Error:${state.error}");
                return ErrorPage(
                  errorMsg: state.error,
                  onPressedRetryButton: () {
                    _viewMoreEmployeeCubit!
                        .getViewMoreEmployeeData(widget.position);
                  },
                );
              }
              if (state is ViewMoreEmployeeLoadedState) {
                return SizedBox(
                  width: size!.width,
                  height: size!.height,
                  child: Theme(
                    data: Theme.of(context),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _viewMoreEmployeeCubit!
                            .getViewMoreEmployeeData(widget.position);
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
                              margin:
                                  const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10.0),
                                onTap: () async {
                                  onItemClick(model.viewMore);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          model.companyLogo!,
                                          fit: BoxFit.scaleDown,
                                          width: 100.0,
                                          height: 100.0,
                                          errorBuilder: (context, error, stackTrace) =>  const Center(child:  Icon(Icons.broken_image,size: 40,),),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                              const SizedBox(height: 5,),
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
                                              const SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Job Description: ${model.jobDescripton ?? ""}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      "Rating: ${model.rating ?? ""}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5,),
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
                                              const SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      onItemClick(model.viewMore);
                                                    },
                                                    style: TextButton.styleFrom(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 4),
                                                    ),
                                                    child: const Text("View More"),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
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
                  _viewMoreEmployeeCubit!
                      .getViewMoreEmployeeData(widget.position);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> handle_back_press() async {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onItemClick(String? viewMore) async{
    await navigatorKey.currentState!.pushNamed(RouteName.webViewScreenRoute, arguments:viewMore);
  }
}
