import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:colorbracket_yazad/config/config.dart';
import 'package:colorbracket_yazad/model/model.dart';
import 'package:colorbracket_yazad/parser/parser.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial()) {
    getHomeScreenList();
  }

  void getHomeScreenList() async {
    try {
      emit(HomeScreenLoadingState());
      bool result = await InternetConnectionChecker().hasConnection;
      if (result == false) {
        emit(HomeScreenNoInternetState());
      } else {
        Map result = await HttpCallGenerator.getApiCall(
            url: "https://retoolapi.dev/GFHqAV/getemployees",
            header: jsonEncode(AppConfig.httpGetHeader));

        if (result["isError"] == true) {
          emit(HomeScreenErrorState(result["response"]));
        } else {
          final homeUserModel = homeUserModelFromJson(result["response"]);
          emit(HomeScreenLoadedState(homeUserModel));
        }
      }
    } catch (e) {
      emit(HomeScreenErrorState(e.toString()));
    }
  }
}
