import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/brand_models/brand.dart';
import '../../../../viewmodel/car_providers.dart';

class CarSelectionDialog extends ConsumerStatefulWidget {
  const CarSelectionDialog({Key? key, required this.brandRef})
      : super(key: key);
  final List<BrandModel> brandRef;
  @override
  ConsumerState<CarSelectionDialog> createState() => _CarSelectionDialogState();
}

class _CarSelectionDialogState extends ConsumerState<CarSelectionDialog> {
  String selectedBrand = "all";
  String selectedStatus = "all";

  @override
  void initState() {
    super.initState();
    ref.read(carProvider);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter Car'),
      content: SizedBox(
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Radio buttons for car brands
              Text(
                'Filter Brand',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              for (BrandModel brand in widget.brandRef)
                ListTile(
                  title: Text(brand.brandName),
                  leading: Radio<String>(
                    value: brand.brandName,
                    groupValue: selectedBrand,
                    onChanged: (String? value) {
                      setState(() {
                        selectedBrand = value!;
                      });
                    },
                    toggleable: true,
                  ),
                ),
              // Checkbox for availability
              Divider(),
              Text('Filter Status',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              ListTile(
                title: Text("Available"),
                leading: Radio<String>(
                  value: "available",
                  groupValue: selectedStatus,
                  onChanged: (String? value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("Not Available"),
                leading: Radio<String>(
                  value: "notavailable",
                  groupValue: selectedStatus,
                  onChanged: (String? value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("All Status"),
                leading: Radio<String>(
                  value: "all",
                  groupValue: selectedStatus,
                  onChanged: (String? value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (selectedBrand != "all" && selectedStatus != "all") {
              ref
                  .watch(carProvider.notifier)
                  .filterCar(selectedBrand, selectedStatus);
            } else if (selectedBrand != "all") {
              ref
                  .watch(carProvider.notifier)
                  .filterCar(selectedBrand, selectedStatus);
            } else {
              ref
                  .watch(carProvider.notifier)
                  .filterCar(selectedBrand, selectedStatus);
            }

            Navigator.of(context).pop();
          },
          child: Text('Ok'),
        ),
      ],
    );
  }
}

void showCarSelectionDialog(BuildContext context, List<BrandModel> brand) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CarSelectionDialog(
        brandRef: brand,
      );
    },
  );
}
