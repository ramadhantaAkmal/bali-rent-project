import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class OrderModel with _$OrderModel {
  factory OrderModel({
    required int id,
    required String orderDate,
    required String startDate,
    required String finishDate,
    required int carId,
    required int userId,
    required int rentHouseId,
    required String paymentId,
    required String transactionStatus,
    required int totalFare,
    required Map<dynamic, dynamic> car,
    required Map<dynamic, dynamic> rentHouse,
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
