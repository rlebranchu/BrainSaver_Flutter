import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// The category is use to defined which color of appointment in
class CategoryAppointment extends Equatable {
  final String name;
  final Color color;

  const CategoryAppointment({required this.name, required this.color});

  // Defined color is category doesn't exist
  static const error =
      CategoryAppointment(name: 'error', color: Colors.blueGrey);

  // Function to check if parameter is the good category
  bool isCategoryNamed(String name) => this.name == name;

  @override
  List<Object?> get props => [name, color];
}
