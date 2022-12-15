import 'dart:convert';
import 'dart:math';

import 'package:colorbracket_yazad/bloc/bloc.dart';
import 'package:colorbracket_yazad/config/config.dart';
import 'package:colorbracket_yazad/main.dart';
import 'package:colorbracket_yazad/parser/parser.dart';
import 'package:colorbracket_yazad/utlis/utlis.dart';
import 'package:colorbracket_yazad/widgets/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:particles_flutter/particles_flutter.dart';

import '../../routing/routs.dart';

class LoginScreen extends StatefulWidget {
  bool? isFirstTime;

  LoginScreen({Key? key, required this.isFirstTime}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Size? size;
  Orientation? orientation;
  LoginScreenCubit? _loginScreenCubit;
  final _formKey = GlobalKey<FormState>();
  TextEditingController? emailTextEditingController,
      passwordTextEditingController;
  FocusNode? emailFocusNode, passwordFocusNode;

  bool? isButtonLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loginScreenCubit?.dispose();
    });
    emailTextEditingController =
        TextEditingController(text: "efoat3d@list-manage.com");
    passwordTextEditingController = TextEditingController(text: "user_357");
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    orientation = MediaQuery.of(context).orientation;
    _loginScreenCubit = BlocProvider.of<LoginScreenCubit>(
      context,
      listen: false,
    );
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
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
                    awayRadius: 100,
                    numberOfParticles: 250,
                    connectDots: false,
                    enableHover: false,
                    hoverColor: Theme.of(context).indicatorColor,
                    hoverRadius: 50,
                    speedOfParticles: 1.3,
                    width: size!.width,
                    height: size!.height,
                    onTapAnimation: true,
                    particleColor: Colors.white.withAlpha(150),
                    awayAnimationDuration: const Duration(milliseconds: 600),
                    maxParticleSize: 8,
                    isRandSize: true,
                    isRandomColor: true,
                    randColorList: [
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
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ListView(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          Theme(
                            data: Theme.of(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: SizedBox(
                                      width: size!.width * .85,
                                      child: Card(
                                        elevation: 2,
                                        child: Theme(
                                          data: Theme.of(context),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 5, 10, 0),
                                                        child: Text(
                                                          widget.isFirstTime ==
                                                                  true
                                                              ? "Welcome"
                                                              : "Welcome Back",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline4!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 10, 10, 0),
                                                        child:
                                                            TextFormEmailField(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                10, 10, 10, 10),
                                                        child:
                                                            TextFormPasswordField(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                sign_in(),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5,
                                                                right: 5),
                                                        child: Text(
                                                          "Don't have an account?",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge!,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Center(
                                                        child: TextButton(
                                                          onPressed: () {},
                                                          style: ButtonStyle(
                                                            padding:
                                                                MaterialStateProperty
                                                                    .all<
                                                                        EdgeInsets>(
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 30,
                                                                  right: 30,
                                                                  bottom: 5,
                                                                  top: 5),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                            "Sign Up",
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Divider(
                                                        color: MediaQuery.of(
                                                                        context)
                                                                    .platformBrightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : Colors.black,
                                                        height: 1,
                                                        endIndent: 25,
                                                        indent: 25,
                                                        thickness: 1,
                                                      ),
                                                    ),
                                                    HoverUpDownWidget(
                                                      animationDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  1500),
                                                      childWidget: Text(
                                                        "Or",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  color: MediaQuery.of(context)
                                                                              .platformBrightness ==
                                                                          Brightness
                                                                              .dark
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                        child: Divider(
                                                      color: MediaQuery.of(
                                                                      context)
                                                                  .platformBrightness ==
                                                              Brightness.dark
                                                          ? Colors.white
                                                          : Colors.black,
                                                      height: 1,
                                                      endIndent: 25,
                                                      indent: 25,
                                                      thickness: 1,
                                                    )),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                social_media_login_row(),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> handle_back_press() async {
    Navigator.pop(context);
  }

  Widget TextFormEmailField(context) {
    return StreamBuilder(
        stream: _loginScreenCubit?.userNameStream,
        builder: (context, snapshot) {
          return TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailTextEditingController!,
            focusNode: emailFocusNode,
            textInputAction: TextInputAction.next,
            validator: (value) {
              bool? isEmailValid = EmailValidator.validate(
                  emailTextEditingController?.text ?? "");
              Constants.debugLog(LoginScreen, "isEmailValid:$isEmailValid");
              bool? noOneLetterDomain =
                  emailTextEditingController!.text.split('.').last.length > 1;
              Constants.debugLog(
                  LoginScreen, "noOneLetterDomain:$noOneLetterDomain");
              if (!isEmailValid && !noOneLetterDomain) {
                return "Please enter a valid email";
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            onChanged: (text) {
              _loginScreenCubit?.updateUserName(text);
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.mail_outline_outlined,
                size: 24,
              ),
              label: const Text("Email"),
              hintText: "Enter your Email address.",
              isDense: true,
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(5),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        });
  }

  Widget TextFormPasswordField(context) {
    return StreamBuilder(
        stream: _loginScreenCubit?.passwordStream,
        builder: (context, snapshot) {
          return TextFormField(
            controller: passwordTextEditingController!,
            focusNode: passwordFocusNode,
            textInputAction: TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: (value) =>
                FocusScope.of(context).requestFocus(FocusNode()),
            onChanged: (value) {
              _loginScreenCubit?.updatePassword(value);
            },
            validator: (value) {
              // r'^
              //   (?=.*[A-Z])       // should contain at least one upper case
              //   (?=.*[a-z])       // should contain at least one lower case
              //   (?=.*?[0-9])      // should contain at least one digit
              //   (?=.*?[!@#\$&*~]) // should contain at least one Special character
              //     .{8,}             // Must be at least 8 characters in length
              // $
              RegExp regex = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
              if (value!.isEmpty) {
                return 'Please enter password';
              }
              // else if (regex.hasMatch(value)) {
              //   return 'Enter valid password';
              // }
              else {
                return null;
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(FontAwesomeIcons.userLock),
              label: const Text("Password"),
              hintText: "Enter your password.",
              isDense: true,
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(5),
              ),
              errorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.error),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          );
        });
  }

  Widget sign_in() {
    return StreamBuilder(
        stream: _loginScreenCubit?.validateForm,
        builder: (context, snapshot1) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: StreamBuilder(
                      stream: _loginScreenCubit?.buttonLoadingStream,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                          onPressed: () async {
                            _loginScreenCubit?.updateButtonLoading(true);

                            if (_formKey.currentState!.validate()) {
                              // if (snapshot1.hasData) {
                              await callLoginApi();
                              // } else {
                              //   _loginScreenCubit?.updateButtonLoading(false);
                              // }
                            } else {
                              _loginScreenCubit?.updateButtonLoading(false);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).primaryColorLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal),
                          ),
                          child: snapshot.data == false
                              ? Text("Login")
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator.adaptive(
                                        strokeWidth: 3,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Please Wait...")
                                  ],
                                ),
                        );
                      }),
                ),
              )
            ],
          );
        });
  }

  Widget social_media_login_row() {
    return Container(
      width: size!.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          HoverUpDownWidget(
            animationDuration: const Duration(milliseconds: 1500),
            childWidget: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 3,
                padding: const EdgeInsets.only(left: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: const Center(
                child: Icon(FontAwesomeIcons.facebookF, size: 24),
              ),
              label: const Text(""),
            ),
          ),
          HoverUpDownWidget(
            animationDuration: const Duration(milliseconds: 1800),
            childWidget: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 3,
                padding: const EdgeInsets.only(left: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: const Center(
                child: Icon(FontAwesomeIcons.google, size: 24),
              ),
              label: const Text(""),
            ),
          ),
          HoverUpDownWidget(
            animationDuration: const Duration(milliseconds: 2000),
            childWidget: ElevatedButton.icon(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                elevation: 3,
                padding: const EdgeInsets.only(left: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: const Center(
                child: Icon(CustomIcon.smartphone, size: 26),
              ),
              label: const Text(""),
            ),
          ),
        ],
      ),
    );
  }

  clearTextData() {
    emailTextEditingController!.clear();
    passwordTextEditingController!.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    clearTextData();
    emailTextEditingController?.dispose();
    passwordTextEditingController?.dispose();
    emailFocusNode?.dispose();
    passwordFocusNode?.dispose();

    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  NavigateToHomePage() async {
    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(RouteName.homeScreenRoute, (route) => false);
  }

  callLoginApi() async {
    Map? result = await HttpCallGenerator.getApiCall(
        url:
            "https://retoolapi.dev/B13laa/getusers?user_id=${emailTextEditingController?.text.toString()}&password=${passwordTextEditingController?.text.toString()}",
        header: jsonEncode(AppConfig.httpGetHeader));
    if (result!["isError"] == true) {
      _loginScreenCubit?.updateButtonLoading(false);
      _showError(result["response"]);
    } else {
      Constants.debugLog(LoginScreen, "${result["response"]}");
      await Future.delayed(Duration(milliseconds: 500));
      _loginScreenCubit?.updateButtonLoading(false);
      NavigateToHomePage();
    }
  }
}
