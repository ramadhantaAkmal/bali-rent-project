import 'dart:developer';

import 'package:bali_rent/models/renthouse_models/renthouse.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../fetchs/renthouse_fetch.dart';
import '../models/car_models/car.dart';

class DetailNotifier extends StateNotifier<Map<String, Object>> {
  DetailNotifier() : super({"": {}});

  void getCarDetails(CarModel car, int id) async {
    try {
      var rawStoreData = await RentHouseApi.getStoreDatas(id);
      var storeData = RentHouseModel.fromJson(rawStoreData["data"]);
      state = {"CarData": car, "RentHouseData": storeData};
    } catch (e) {
      log(e.toString());
    }
  }
}

final detailProvider =
    StateNotifierProvider<DetailNotifier, Map<String, Object>>((ref) {
  return DetailNotifier();
});
