import 'dart:convert';

import 'package:bali_rent/fetchs/order_fetch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderNotifier extends StateNotifier<Map<String, dynamic>> {
  OrderNotifier() : super({"": {}});

  void saveBooked(DateTime to, DateTime from, int totalFare, int carId) {
    state = {
      "to": to,
      "from": from,
      "totalFare": totalFare,
      "carID": carId,
    };
  }

  void addOrder(String bank) async {
    var dateToday = DateTime.now().toString();
    var startDate = state["from"].toString();
    var finishDate = state["to"].toString();
    var amount = state["totalFare"];
    var carId = state["carID"];

    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = json.decode(pref.getString("token")!);

    var res = await OrderApi.inputOrder(bank, dateToday, startDate, finishDate,
        carId, amount, token["access_token"]);
    print(res);
    var dataRes;
    state = {};
    try {
      dataRes = res["data"]["va_numbers"][0];
      state = {"bank": "bca", "va_num": dataRes["va_number"]};
    } catch (e) {
      dataRes = res["data"]["permata_va_number"];
      state = {"bank": "permata", "va_num": dataRes};
    }
  }
}

final orderProvider =
    StateNotifierProvider<OrderNotifier, Map<String, dynamic>>((ref) {
  return OrderNotifier();
});
