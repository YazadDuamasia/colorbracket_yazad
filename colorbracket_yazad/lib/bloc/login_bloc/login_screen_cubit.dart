import 'package:colorbracket_yazad/utlis/components/constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit() : super(LoginScreenInitial());

  //define controllers
  final _userNameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _buttonLoading = BehaviorSubject<bool>();

  //get data
  Stream<String> get userNameStream => _userNameController.stream;

  Stream<String> get passwordStream => _passwordController.stream;
  Stream<bool> get buttonLoadingStream => _buttonLoading.stream;

  //clear the data
  void dispose() {
    updateUserName('');
    updatePassword('');
    updateButtonLoading(false);
  }

  //validation of UserName
  void updateUserName(String userName) {
    bool? isEmailValid = EmailValidator.validate(userName ?? "");
    Constants.debugLog(LoginScreenCubit, "isEmailValid:$isEmailValid");
    bool? noOneLetterDomain = userName.split('.').last.length > 1;
    Constants.debugLog(
        LoginScreenCubit, "noOneLetterDomain:$noOneLetterDomain");
    if (!isEmailValid && !noOneLetterDomain) {
      _userNameController.sink.addError("Please enter a valid email");
    } else {
      _userNameController.sink.add(userName);
    }
    // if (userName.length < 3) {
    //   _userNameController.sink.addError("Please enter at least 3 words");
    // } else {
    //   _userNameController.sink.add(userName);
    // }
  }

  //validation of Password
  void updatePassword(String password) {
    if (password.isEmpty) {
      _passwordController.sink.addError("Please enter your password");
    } else if (password.length < 5) {
      _passwordController.sink.addError("Please enter more then 4 words");
    } else {
      _passwordController.sink.add(password);
    }
  }

  void updateButtonLoading(bool? isloading) {
    _buttonLoading.sink.add(isloading!);
  }

  //check validation
  Stream<bool> get validateForm => Rx.combineLatest2(
        userNameStream,
        passwordStream,
        (a, b) => true,
      );


}
