// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'renthouse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RentHouseModel _$$_RentHouseModelFromJson(Map<String, dynamic> json) =>
    _$_RentHouseModel(
      address: json['address'] as String,
      employeeId: json['employeeId'] as int,
      employee: json['employee'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_RentHouseModelToJson(_$_RentHouseModel instance) =>
    <String, dynamic>{
      'address': instance.address,
      'employeeId': instance.employeeId,
      'employee': instance.employee,
    };
