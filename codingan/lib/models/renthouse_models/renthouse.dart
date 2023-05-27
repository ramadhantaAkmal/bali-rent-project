import 'package:freezed_annotation/freezed_annotation.dart';

part 'renthouse.freezed.dart';
part 'renthouse.g.dart';

@freezed
class RentHouseModel with _$RentHouseModel {
  factory RentHouseModel({
    required String address,
    required int employeeId,
    required Map<dynamic, dynamic> employee,
  }) = _RentHouseModel;

  factory RentHouseModel.fromJson(Map<String, dynamic> json) =>
      _$RentHouseModelFromJson(json);
}
