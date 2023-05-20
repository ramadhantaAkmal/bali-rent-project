// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BrandModel _$BrandModelFromJson(Map<String, dynamic> json) {
  return _BrandModel.fromJson(json);
}

/// @nodoc
mixin _$BrandModel {
  String get brandName => throw _privateConstructorUsedError;
  String get brandImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BrandModelCopyWith<BrandModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrandModelCopyWith<$Res> {
  factory $BrandModelCopyWith(
          BrandModel value, $Res Function(BrandModel) then) =
      _$BrandModelCopyWithImpl<$Res, BrandModel>;
  @useResult
  $Res call({String brandName, String brandImage});
}

/// @nodoc
class _$BrandModelCopyWithImpl<$Res, $Val extends BrandModel>
    implements $BrandModelCopyWith<$Res> {
  _$BrandModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandName = null,
    Object? brandImage = null,
  }) {
    return _then(_value.copyWith(
      brandName: null == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String,
      brandImage: null == brandImage
          ? _value.brandImage
          : brandImage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BrandModelCopyWith<$Res>
    implements $BrandModelCopyWith<$Res> {
  factory _$$_BrandModelCopyWith(
          _$_BrandModel value, $Res Function(_$_BrandModel) then) =
      __$$_BrandModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String brandName, String brandImage});
}

/// @nodoc
class __$$_BrandModelCopyWithImpl<$Res>
    extends _$BrandModelCopyWithImpl<$Res, _$_BrandModel>
    implements _$$_BrandModelCopyWith<$Res> {
  __$$_BrandModelCopyWithImpl(
      _$_BrandModel _value, $Res Function(_$_BrandModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandName = null,
    Object? brandImage = null,
  }) {
    return _then(_$_BrandModel(
      brandName: null == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String,
      brandImage: null == brandImage
          ? _value.brandImage
          : brandImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BrandModel implements _BrandModel {
  _$_BrandModel({required this.brandName, required this.brandImage});

  factory _$_BrandModel.fromJson(Map<String, dynamic> json) =>
      _$$_BrandModelFromJson(json);

  @override
  final String brandName;
  @override
  final String brandImage;

  @override
  String toString() {
    return 'BrandModel(brandName: $brandName, brandImage: $brandImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BrandModel &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.brandImage, brandImage) ||
                other.brandImage == brandImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, brandName, brandImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BrandModelCopyWith<_$_BrandModel> get copyWith =>
      __$$_BrandModelCopyWithImpl<_$_BrandModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BrandModelToJson(
      this,
    );
  }
}

abstract class _BrandModel implements BrandModel {
  factory _BrandModel(
      {required final String brandName,
      required final String brandImage}) = _$_BrandModel;

  factory _BrandModel.fromJson(Map<String, dynamic> json) =
      _$_BrandModel.fromJson;

  @override
  String get brandName;
  @override
  String get brandImage;
  @override
  @JsonKey(ignore: true)
  _$$_BrandModelCopyWith<_$_BrandModel> get copyWith =>
      throw _privateConstructorUsedError;
}
