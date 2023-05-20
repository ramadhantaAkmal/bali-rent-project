import 'package:bali_rent/fetchs/brand_fetch.dart';
import 'package:bali_rent/models/brand_models/brand.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandsNotifier extends StateNotifier<List<BrandModel>> {
  BrandsNotifier([List<BrandModel>? initialBrands])
      : super(initialBrands ?? []);

  void getBrands() async {
    var brandDatas = await BrandApi.getBrands();
    state = brandDatas.map<BrandModel>((data) {
      return BrandModel.fromJson({
        "brandName": data["brandName"],
        "brandImage": data["brandImage"],
      });
    }).toList();
  }
}

final brandProvider = StateNotifierProvider<BrandsNotifier, List<BrandModel>>(
    (ref) => BrandsNotifier());
