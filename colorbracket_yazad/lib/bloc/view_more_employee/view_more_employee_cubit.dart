import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:colorbracket_yazad/config/config.dart';
import 'package:colorbracket_yazad/model/model.dart';
import 'package:colorbracket_yazad/parser/parser.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'view_more_employee_state.dart';

class ViewMoreEmployeeCubit extends Cubit<ViewMoreEmployeeState> {


  ViewMoreEmployeeCubit() : super(ViewMoreEmployeeInitial()) ;

  void getViewMoreEmployeeData(int? position) async {
    try {
      emit(ViewMoreEmployeeLoadingState());
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        emit(ViewMoreEmployeeNoInternetState());
      } else {
        Map result = await HttpCallGenerator.getApiCall(
            url: "https://retoolapi.dev/H2F0Ui/getemployedetail?id=$position",
            header: jsonEncode(AppConfig.httpGetHeader));

        if (result["isError"] == true) {
          emit(ViewMoreEmployeeErrorState(result["response"]));
        } else {
          final viewMoreEmployeeModel =
              viewMoreEmployeeModelFromJson(result["response"]);
          emit(ViewMoreEmployeeLoadedState(viewMoreEmployeeModel));
        }
      }
    } catch (e) {
      emit(ViewMoreEmployeeErrorState(e.toString()));
    }
  }
}
