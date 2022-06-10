part of 'home_nav_cubit.dart';

class HomeNavState extends Equatable {
  final int index;

  const HomeNavState(this.index);

  @override
  List<Object> get props => [index];
}
