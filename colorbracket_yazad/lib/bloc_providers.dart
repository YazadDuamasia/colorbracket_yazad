import 'package:colorbracket_yazad/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/config.dart';



List<BlocProvider> blocProviders = [
  BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
  BlocProvider<LoginScreenCubit>(create: (context) => LoginScreenCubit()),
  BlocProvider<HomeScreenCubit>(create: (context) => HomeScreenCubit()),
];