// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CarModel _$$_CarModelFromJson(Map<String, dynamic> json) => _$_CarModel(
      name: json['name'] as String,
      rentPrice: json['rentPrice'] as int,
      plateNumber: json['plateNumber'] as String,
      fuelType: json['fuelType'] as String,
      seatCount: json['seatCount'] as int,
      carYear: json['carYear'] as int,
      transmission: json['transmission'] as String,
      wdType: json['wdType'] as String,
      carImage: json['carImage'] as String,
      status: json['status'] as String,
      brand: json['brand'] as Map<String, dynamic>,
      rentHouse: json['rentHouse'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_CarModelToJson(_$_CarModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rentPrice': instance.rentPrice,
      'plateNumber': instance.plateNumber,
      'fuelType': instance.fuelType,
      'seatCount': instance.seatCount,
      'carYear': instance.carYear,
      'transmission': instance.transmission,
      'wdType': instance.wdType,
      'carImage': instance.carImage,
      'status': instance.status,
      'brand': instance.brand,
      'rentHouse': instance.rentHouse,
    };
