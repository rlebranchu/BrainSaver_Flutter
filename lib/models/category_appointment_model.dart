import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryAppointment extends Equatable {
  final String name;
  final Color color;

  const CategoryAppointment({required this.name, required this.color});

  static const error =
      CategoryAppointment(name: 'error', color: Colors.blueGrey);

  bool isCategoryNamed(String name) => this.name == name;

  @override
  List<Object?> get props => [name, color];
}
