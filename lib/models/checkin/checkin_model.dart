// To parse this JSON data, do
//
//     final checkinModel = checkinModelFromMap(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'checkin_model.freezed.dart';
part 'checkin_model.g.dart';

//This is a class model for the Checkin Data this is uses the freezer code generator
@unfreezed
abstract class CheckinModel with _$CheckinModel {
  const factory CheckinModel({
    final DateTime? checkin,
    final String? location,
    final String? purpose,
    final String? id,
    final String? employeeId,
  }) = _CheckinModel;

  factory CheckinModel.fromJson(Map<String, dynamic> json) =>
      _$CheckinModelFromJson(json);
}
