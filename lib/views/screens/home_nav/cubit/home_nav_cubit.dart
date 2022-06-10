import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'home_nav_state.dart';

class HomeNavCubit extends Cubit<HomeNavState> {
  HomeNavCubit() : super(const HomeNavState(1));

  void setNavBarItemSelected(int index) {
    emit(HomeNavState(index));
  }
}
