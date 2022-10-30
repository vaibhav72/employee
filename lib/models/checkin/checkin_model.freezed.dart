// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'checkin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CheckinModel _$CheckinModelFromJson(Map<String, dynamic> json) {
  return _CheckinModel.fromJson(json);
}

/// @nodoc
mixin _$CheckinModel {
  DateTime? get checkin => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get purpose => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get employeeId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CheckinModelCopyWith<CheckinModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CheckinModelCopyWith<$Res> {
  factory $CheckinModelCopyWith(
          CheckinModel value, $Res Function(CheckinModel) then) =
      _$CheckinModelCopyWithImpl<$Res, CheckinModel>;
  @useResult
  $Res call(
      {DateTime? checkin,
      String? location,
      String? purpose,
      String? id,
      String? employeeId});
}

/// @nodoc
class _$CheckinModelCopyWithImpl<$Res, $Val extends CheckinModel>
    implements $CheckinModelCopyWith<$Res> {
  _$CheckinModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkin = freezed,
    Object? location = freezed,
    Object? purpose = freezed,
    Object? id = freezed,
    Object? employeeId = freezed,
  }) {
    return _then(_value.copyWith(
      checkin: freezed == checkin
          ? _value.checkin
          : checkin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      purpose: freezed == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CheckinModelCopyWith<$Res>
    implements $CheckinModelCopyWith<$Res> {
  factory _$$_CheckinModelCopyWith(
          _$_CheckinModel value, $Res Function(_$_CheckinModel) then) =
      __$$_CheckinModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime? checkin,
      String? location,
      String? purpose,
      String? id,
      String? employeeId});
}

/// @nodoc
class __$$_CheckinModelCopyWithImpl<$Res>
    extends _$CheckinModelCopyWithImpl<$Res, _$_CheckinModel>
    implements _$$_CheckinModelCopyWith<$Res> {
  __$$_CheckinModelCopyWithImpl(
      _$_CheckinModel _value, $Res Function(_$_CheckinModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? checkin = freezed,
    Object? location = freezed,
    Object? purpose = freezed,
    Object? id = freezed,
    Object? employeeId = freezed,
  }) {
    return _then(_$_CheckinModel(
      checkin: freezed == checkin
          ? _value.checkin
          : checkin // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      purpose: freezed == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeId: freezed == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CheckinModel implements _CheckinModel {
  const _$_CheckinModel(
      {this.checkin, this.location, this.purpose, this.id, this.employeeId});

  factory _$_CheckinModel.fromJson(Map<String, dynamic> json) =>
      _$$_CheckinModelFromJson(json);

  @override
  final DateTime? checkin;
  @override
  final String? location;
  @override
  final String? purpose;
  @override
  final String? id;
  @override
  final String? employeeId;

  @override
  String toString() {
    return 'CheckinModel(checkin: $checkin, location: $location, purpose: $purpose, id: $id, employeeId: $employeeId)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CheckinModelCopyWith<_$_CheckinModel> get copyWith =>
      __$$_CheckinModelCopyWithImpl<_$_CheckinModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CheckinModelToJson(
      this,
    );
  }
}

abstract class _CheckinModel implements CheckinModel {
  const factory _CheckinModel(
      {final DateTime? checkin,
      final String? location,
      final String? purpose,
      final String? id,
      final String? employeeId}) = _$_CheckinModel;

  factory _CheckinModel.fromJson(Map<String, dynamic> json) =
      _$_CheckinModel.fromJson;

  @override
  DateTime? get checkin;
  @override
  String? get location;
  @override
  String? get purpose;
  @override
  String? get id;
  @override
  String? get employeeId;
  @override
  @JsonKey(ignore: true)
  _$$_CheckinModelCopyWith<_$_CheckinModel> get copyWith =>
      throw _privateConstructorUsedError;
}
