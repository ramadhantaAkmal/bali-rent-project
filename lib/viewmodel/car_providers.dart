import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../fetchs/car_fetch.dart';
import '../models/car_models/car.dart';

class CarNotifier extends StateNotifier<List<CarModel>> {
  CarNotifier([List<CarModel>? initialCars]) : super(initialCars ?? []);

  List<CarModel> carSaved = [];

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
    carSaved = state;
  }

  void searchCars(String query) {
    state = carSaved.where((car) {
      final carName = car.name.toLowerCase();
      final input = query.toLowerCase();

      return carName.contains(input);
    }).toList();
  }

  void filterCar(String brand, String statusInput) {
    state = carSaved.where((car) {
      final String brandName = car.brand["brandName"].toLowerCase();
      final input = brand.toLowerCase();
      final status = car.status.toLowerCase();

      //return true if user doesn`t choose anyting
      if (brand == "all" && statusInput == "all") {
        return true;
      }

      //return true if user choose one of the brands but not the status
      if (brandName.contains(input) && statusInput == "all") {
        return true;
      }
      //return true if user choose one of the status but not the brand
      if (brand == "all" && status == statusInput) {
        return true;
      }

      //return false to filter the data returned
      return false;
    }).toList();
  }
}

final carProvider =
    StateNotifierProvider<CarNotifier, List<CarModel>>((ref) => CarNotifier());
