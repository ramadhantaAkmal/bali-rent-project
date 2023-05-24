import 'package:bali_rent/style.dart';
import 'package:bali_rent/views/ui/carlist_page/carlist_widget/car_card.dart';
import 'package:bali_rent/views/ui/carlist_page/carlist_widget/car_filter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../models/brand_models/brand.dart';
import '../../../models/car_models/car.dart';
import '../../../viewmodel/brand_providers.dart';
import '../../../viewmodel/car_providers.dart';

class CarListMain extends ConsumerStatefulWidget {
  const CarListMain({super.key});

  @override
  ConsumerState<CarListMain> createState() => _CarListMainState();
}

class _CarListMainState extends ConsumerState<CarListMain> {
  @override
  void initState() {
    super.initState();
    ref.read(carProvider);
  }

  late List<CarModel> _carRef;
  late List<BrandModel> _brandRef;
  final TextEditingController _searchController = TextEditingController();

  void _onSearchCar(String query) {
    ref.read(carProvider.notifier).searchCars(query);
  }

  @override
  Widget build(BuildContext context) {
    _carRef = ref.watch(carProvider);
    _brandRef = ref.watch(brandProvider);
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(context, _carRef, _brandRef),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: themeColor,
      leading: Container(
        margin: const EdgeInsets.only(left: 7, top: 4, right: 10, bottom: 10),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 11,
              offset: const Offset(6, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Center(
            child: IconButton(
              iconSize: 20,
              onPressed: () {
                ref.read(carProvider.notifier).getCars();
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, List<CarModel> carRef, List<BrandModel> brandRef) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      fillColor: themeColor,
                      prefixIconColor: themeColor,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search Car ...',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(color: themeColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(color: themeColor),
                      ),
                    ),
                    onChanged: (text) {
                      _onSearchCar(text);
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    fixedSize: const Size(75, 40),
                    side: const BorderSide(
                      strokeAlign: 10,
                      color: themeColor,
                    ),
                  ),
                  onPressed: () {
                    showCarSelectionDialog(context, brandRef);
                    // _onShowFilters(_brandRef);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Flexible(
                        flex: 3,
                        child: Text(
                          "Filter",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Icon(
                          Icons.filter_list,
                          color: primaryColor,
                          size: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => CarListCard(carRef[index]),
              itemCount: carRef.length,
            ),
          ),
        ],
      ),
    );
  }
}
