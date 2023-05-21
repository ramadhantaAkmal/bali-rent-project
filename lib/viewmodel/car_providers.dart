import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../fetchs/car_fetch.dart';
import '../models/car_models/car.dart';

class CarNotifier extends StateNotifier<List<CarModel>> {
  CarNotifier([List<CarModel>? initialBrands]) : super(initialBrands ?? []);

  void getCars() async {
    var carResponse = await CarApi.getCars();
    var carDatas = carResponse["data"];
    state = carDatas.map<CarModel>((data) {
      return CarModel.fromJson({
        "name": data["name"],
        "rentPrice": data["rentPrice"],
        "plateNumber": data["plateNumber"],
        "fuelType": data["fuelType"],
        "seatCount": data["seatCount"],
        "carYear": data["carYear"],
        "transmission": data["transmission"],
        "wdType": data["wdType"],
        "carImage": data["carImage"],
        "status": data["status"],
        "brand": data["brand"],
        "rentHouse": data["rentHouse"],
      });
    }).toList();
  }
}

final carProvider =
    StateNotifierProvider<CarNotifier, List<CarModel>>((ref) => CarNotifier());
