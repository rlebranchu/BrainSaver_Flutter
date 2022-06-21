import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? name;

  const User({required this.id, this.email, this.name});

  static const empty = User(id: '');

  // Functions to define if object is empty or not
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, email, name];
}
