import 'package:bali_rent/models/renthouse_models/renthouse.dart';
import 'package:bali_rent/viewmodel/detail_providers.dart';
import 'package:flutter/material.dart';
import 'package:bali_rent/style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/car_models/car.dart';

class DetailMain extends ConsumerWidget {
  const DetailMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(detailProvider);
    final CarModel? carData = detail["CarData"] as CarModel? ??
        CarModel(
            id: 0,
            name: "",
            rentPrice: 0,
            plateNumber: "",
            fuelType: "",
            seatCount: 0,
            carYear: 0,
            transmission: "",
            wdType: "",
            carImage: "",
            status: "",
            brand: {},
            rentHouse: {});
    final RentHouseModel? renterData =
        detail["RentHouseData"] as RentHouseModel? ??
            RentHouseModel(address: "address", employeeId: 0, employee: {});
    return Scaffold(
      appBar: _buildAppBar(context, ref),
      body: _buildBody(context, carData, renterData),
    );
  }

  void _openWa(String num) async {
    String url = "https://api.whatsapp.com/send?phone=$num=hello";

    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  void _openCall(String num) async {
    String url = "tel:$num";

    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  AppBar _buildAppBar(BuildContext context, WidgetRef ref) {
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
                context.pop();
                ref.invalidate(detailProvider);
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
      BuildContext context, CarModel? carData, RentHouseModel? renterData) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(3, 4),
                    color: Colors.black26),
              ],
            ),
            child: Image(
              image: NetworkImage(carData!.carImage),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carData.name,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      carData.status,
                      style: TextStyle(
                        fontSize: 15,
                        color: carData.status == "Available"
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                    Text(
                      renterData!.address,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text.rich(
                    TextSpan(children: [
                      const TextSpan(text: "From "),
                      TextSpan(
                        text: NumberFormat.currency(
                          locale: 'id',
                          symbol: 'Rp ',
                          decimalDigits: 0,
                        ).format(carData.rentPrice),
                      ),
                      const TextSpan(text: "/day"),
                    ]),
                    style: const TextStyle(
                      fontSize: 15,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    renterData.employee["name"] ?? "name",
                    style: const TextStyle(fontSize: 15),
                  ),
                  const Text(
                    'Renter',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 7, top: 4, right: 8, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
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
                    child: IconButton(
                      onPressed: () {
                        _openWa(renterData.employee["phoneNumber"] ?? "000");
                      },
                      icon: const Icon(
                        Icons.chat,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 1, top: 4, right: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
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
                    child: IconButton(
                      onPressed: () {
                        _openCall(renterData.employee["phoneNumber"] ?? "000");
                      },
                      icon: const Icon(
                        Icons.phone,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
          const Text(
            'Car Info',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(
            flex: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.airline_seat_recline_normal,
                          color: primaryColor,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${carData.seatCount} Seat",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/Engine.png'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          carData.transmission,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.local_gas_station,
                          color: primaryColor,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          carData.fuelType,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/images/4WD.png'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          carData.wdType,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(
            flex: 10,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: MaterialButton(
              onPressed: carData.status == "NotAvailable"
                  ? null
                  : () {
                      context.push('/homescreen/detail/order');
                    },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              disabledColor: Colors.grey,
              color: primaryColor,
              child: const Text(
                'Rent It!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
