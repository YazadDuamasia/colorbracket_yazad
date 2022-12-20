part of 'view_more_employee_cubit.dart';

abstract class ViewMoreEmployeeState extends Equatable {
  const ViewMoreEmployeeState();
}

class ViewMoreEmployeeInitial extends ViewMoreEmployeeState {
  @override
  List<Object> get props => [];
}


class ViewMoreEmployeeLoadingState extends ViewMoreEmployeeState {
  @override
  List<Object> get props => [];
}

class ViewMoreEmployeeLoadedState extends ViewMoreEmployeeState {
  const ViewMoreEmployeeLoadedState(this.list);

  final List<ViewMoreEmployeeModel> list;

  @override
  List<Object> get props => [list];
}

class ViewMoreEmployeeErrorState extends ViewMoreEmployeeState {
  String? error;
  ViewMoreEmployeeErrorState(this.error);

  @override
  List<Object> get props => [error!];
}

class ViewMoreEmployeeNoInternetState extends ViewMoreEmployeeState {
  @override
  List<Object> get props => [];
}
