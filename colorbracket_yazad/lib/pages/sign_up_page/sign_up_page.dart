import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Size? size;
  Orientation? orientation;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    orientation = MediaQuery.of(context).orientation;
    return WillPopScope(
      onWillPop: () async {
        handle_back_press();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(),
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
}
