// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderModel _$$_OrderModelFromJson(Map<String, dynamic> json) =>
    _$_OrderModel(
      id: json['id'] as int,
      orderDate: json['orderDate'] as String,
      startDate: json['startDate'] as String,
      finishDate: json['finishDate'] as String,
      carId: json['carId'] as int,
      userId: json['userId'] as int,
      rentHouseId: json['rentHouseId'] as int,
      paymentId: json['paymentId'] as String,
      transactionStatus: json['transactionStatus'] as String,
      car: json['car'] as Map<String, dynamic>,
      rentHouse: json['rentHouse'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_OrderModelToJson(_$_OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderDate': instance.orderDate,
      'startDate': instance.startDate,
      'finishDate': instance.finishDate,
      'carId': instance.carId,
      'userId': instance.userId,
      'rentHouseId': instance.rentHouseId,
      'paymentId': instance.paymentId,
      'transactionStatus': instance.transactionStatus,
      'car': instance.car,
      'rentHouse': instance.rentHouse,
    };
