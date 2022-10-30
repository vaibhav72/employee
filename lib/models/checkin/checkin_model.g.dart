// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CheckinModel _$$_CheckinModelFromJson(Map<String, dynamic> json) =>
    _$_CheckinModel(
      checkin: json['checkin'] == null
          ? null
          : DateTime.parse(json['checkin'] as String),
      location: json['location'] as String?,
      purpose: json['purpose'] as String?,
      id: json['id'] as String?,
      employeeId: json['employeeId'] as String?,
    );

Map<String, dynamic> _$$_CheckinModelToJson(_$_CheckinModel instance) =>
    <String, dynamic>{
      'checkin': instance.checkin?.toIso8601String(),
      'location': instance.location,
      'purpose': instance.purpose,
      'id': instance.id,
      'employeeId': instance.employeeId,
    };
