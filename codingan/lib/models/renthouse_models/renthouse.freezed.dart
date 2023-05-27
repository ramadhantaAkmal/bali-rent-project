// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'renthouse.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RentHouseModel _$RentHouseModelFromJson(Map<String, dynamic> json) {
  return _RentHouseModel.fromJson(json);
}

/// @nodoc
mixin _$RentHouseModel {
  String get address => throw _privateConstructorUsedError;
  int get employeeId => throw _privateConstructorUsedError;
  Map<dynamic, dynamic> get employee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RentHouseModelCopyWith<RentHouseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RentHouseModelCopyWith<$Res> {
  factory $RentHouseModelCopyWith(
          RentHouseModel value, $Res Function(RentHouseModel) then) =
      _$RentHouseModelCopyWithImpl<$Res, RentHouseModel>;
  @useResult
  $Res call({String address, int employeeId, Map<dynamic, dynamic> employee});
}

/// @nodoc
class _$RentHouseModelCopyWithImpl<$Res, $Val extends RentHouseModel>
    implements $RentHouseModelCopyWith<$Res> {
  _$RentHouseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? employeeId = null,
    Object? employee = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      employee: null == employee
          ? _value.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RentHouseModelCopyWith<$Res>
    implements $RentHouseModelCopyWith<$Res> {
  factory _$$_RentHouseModelCopyWith(
          _$_RentHouseModel value, $Res Function(_$_RentHouseModel) then) =
      __$$_RentHouseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String address, int employeeId, Map<dynamic, dynamic> employee});
}

/// @nodoc
class __$$_RentHouseModelCopyWithImpl<$Res>
    extends _$RentHouseModelCopyWithImpl<$Res, _$_RentHouseModel>
    implements _$$_RentHouseModelCopyWith<$Res> {
  __$$_RentHouseModelCopyWithImpl(
      _$_RentHouseModel _value, $Res Function(_$_RentHouseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? employeeId = null,
    Object? employee = null,
  }) {
    return _then(_$_RentHouseModel(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as int,
      employee: null == employee
          ? _value._employee
          : employee // ignore: cast_nullable_to_non_nullable
              as Map<dynamic, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RentHouseModel implements _RentHouseModel {
  _$_RentHouseModel(
      {required this.address,
      required this.employeeId,
      required final Map<dynamic, dynamic> employee})
      : _employee = employee;

  factory _$_RentHouseModel.fromJson(Map<String, dynamic> json) =>
      _$$_RentHouseModelFromJson(json);

  @override
  final String address;
  @override
  final int employeeId;
  final Map<dynamic, dynamic> _employee;
  @override
  Map<dynamic, dynamic> get employee {
    if (_employee is EqualUnmodifiableMapView) return _employee;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_employee);
  }

  @override
  String toString() {
    return 'RentHouseModel(address: $address, employeeId: $employeeId, employee: $employee)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RentHouseModel &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            const DeepCollectionEquality().equals(other._employee, _employee));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, employeeId,
      const DeepCollectionEquality().hash(_employee));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RentHouseModelCopyWith<_$_RentHouseModel> get copyWith =>
      __$$_RentHouseModelCopyWithImpl<_$_RentHouseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RentHouseModelToJson(
      this,
    );
  }
}

abstract class _RentHouseModel implements RentHouseModel {
  factory _RentHouseModel(
      {required final String address,
      required final int employeeId,
      required final Map<dynamic, dynamic> employee}) = _$_RentHouseModel;

  factory _RentHouseModel.fromJson(Map<String, dynamic> json) =
      _$_RentHouseModel.fromJson;

  @override
  String get address;
  @override
  int get employeeId;
  @override
  Map<dynamic, dynamic> get employee;
  @override
  @JsonKey(ignore: true)
  _$$_RentHouseModelCopyWith<_$_RentHouseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
