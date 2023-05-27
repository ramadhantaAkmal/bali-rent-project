import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fetchs/order_fetch.dart';
import '../models/order_models/order.dart';

class HistoryNotifier extends StateNotifier<List<OrderModel>> {
  HistoryNotifier([List<OrderModel>? initialCars]) : super(initialCars ?? []);

  int userId = 0;

  void getOrders() async {
    var orderResponse = await OrderApi.getOrders();
    var orderDatas = orderResponse["data"];

    state = orderDatas.map<OrderModel>((data) {
      List<String> dataArray = data["paymentId"].split('-');
      int totalFare = int.parse(dataArray[2]);
      return OrderModel.fromJson({
        "id": data["id"],
        "orderDate": data["orderDate"],
        "startDate": data["startDate"],
        "finishDate": data["finishDate"],
        "carId": data["carId"],
        "userId": data["userId"],
        "rentHouseId": data["rentHouseId"],
        "paymentId": data["paymentId"],
        "transactionStatus": data["transactionStatus"],
        "totalFare": totalFare,
        "car": data["car"],
        "rentHouse": data["rentHouse"],
      });
    }).toList();
  }

  void setUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = json.decode(pref.getString("token")!);
    userId = token["id"];
  }

  List<OrderModel> filterOrders(String tab) {
    DateTime today = DateTime.now();

    List<OrderModel> filteredOrderAccount = [];
    List<OrderModel> orders = [];

    setUserId();

    switch (tab) {
      case "active":
        if (userId != 0) {
          orders = state.where((data) {
            DateTime finishDate = DateTime.parse(data.finishDate);
            DateTime startDate = DateTime.parse(data.startDate);

            if (startDate.isBefore(today) &&
                finishDate.isAfter(today) &&
                data.userId == userId) {
              return true;
            }

            return false;
          }).toList();
          break;
        }
        orders = state.where((data) {
          DateTime finishDate = DateTime.parse(data.finishDate);
          DateTime startDate = DateTime.parse(data.startDate);

          if (startDate.isBefore(today) && finishDate.isAfter(today)) {
            return true;
          }

          return false;
        }).toList();
        break;
      case "upcoming":
        if (userId != 0) {
          orders = state.where((data) {
            DateTime finishDate = DateTime.parse(data.finishDate);
            DateTime startDate = DateTime.parse(data.startDate);

            if (startDate.isAfter(today) && data.userId == userId) {
              return true;
            }
            return false;
          }).toList();
          break;
        }
        orders = state.where((data) {
          DateTime finishDate = DateTime.parse(data.finishDate);
          DateTime startDate = DateTime.parse(data.startDate);

          if (startDate.isAfter(today)) {
            return true;
          }
          return false;
        }).toList();
        break;
      case "done":
        if (userId != 0) {
          orders = state.where((data) {
            DateTime finishDate = DateTime.parse(data.finishDate);
            DateTime startDate = DateTime.parse(data.startDate);
            if (finishDate.isBefore(today) && data.userId == userId) {
              return true;
            }
            return false;
          }).toList();
          break;
        }
        orders = state.where((data) {
          DateTime finishDate = DateTime.parse(data.finishDate);
          DateTime startDate = DateTime.parse(data.startDate);
          if (finishDate.isBefore(today)) {
            return true;
          }
          return false;
        }).toList();
        break;
      default:
    }

    return orders;
  }
}

final historyProvider =
    StateNotifierProvider<HistoryNotifier, List<OrderModel>>(
        (ref) => HistoryNotifier());
