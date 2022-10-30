// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromMap(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'employee_model.freezed.dart';
part 'employee_model.g.dart';

//This is a class model for the Employee Data this is uses the freezer code generator
@unfreezed
abstract class EmployeeModel with _$EmployeeModel {
  const factory EmployeeModel({
    final DateTime? createdAt,
    final String? name,
    final String? avatar,
    final String? email,
    final String? phone,
    final List<String?>? department,
    final DateTime? birthday,
    final String? country,
    final String? id,
  }) = _EmployeeModel;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);
}
