import 'package:bali_rent/models/brand_models/brand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'car.freezed.dart';
part 'car.g.dart';

@freezed
class CarModel with _$CarModel {
  factory CarModel({
    required String name,
    required int rentPrice,
    required String plateNumber,
    required String fuelType,
    required int seatCount,
    required int carYear,
    required String transmission,
    required String wdType,
    required String carImage,
    required String status,
    required Map<dynamic, dynamic> brand,
    required Map<dynamic, dynamic> rentHouse,
  }) = _CarModel;

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
}
