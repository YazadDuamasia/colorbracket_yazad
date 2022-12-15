part of 'home_screen_cubit.dart';

abstract class HomeScreenState extends Equatable {
  const HomeScreenState();
}

class HomeScreenInitial extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class HomeScreenLoadingState extends HomeScreenState {
  @override
  List<Object> get props => [];
}

class HomeScreenLoadedState extends HomeScreenState {
  const HomeScreenLoadedState(this.list);

  final List<HomeUserModel> list;

  @override
  List<Object> get props => [list];
}

class HomeScreenErrorState extends HomeScreenState {
  String? error;
  HomeScreenErrorState(this.error);
  @override
  List<Object> get props => [];
}

class HomeScreenNoInternetState extends HomeScreenState {
  @override
  List<Object> get props => [];
}
