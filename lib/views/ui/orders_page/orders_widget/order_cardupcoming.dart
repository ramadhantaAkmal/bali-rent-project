import 'package:auto_size_text/auto_size_text.dart';
import 'package:bali_rent/fetchs/order_fetch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../models/order_models/order.dart';
import '../../../../style.dart';
import '../../../../viewmodel/car_providers.dart';

class UpcomingCard extends ConsumerStatefulWidget {
  const UpcomingCard(this.orderData, {super.key});
  final OrderModel orderData;

  @override
  ConsumerState<UpcomingCard> createState() => _UpcomingCardState();
}

class _UpcomingCardState extends ConsumerState<UpcomingCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(carProvider);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurStyle: BlurStyle.solid,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(2, 2),
            ),
          ]),
      height: 230,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: InkSplash.splashFactory,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () {},
          splashColor: Colors.grey,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 5, left: 6, right: 6, bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Order Id: "),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(widget.orderData.paymentId),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                          color: Color(0xFFCF9D1E),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          "Upcoming",
                          style: TextStyle(
                              color: Color(0xFF956F0D),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: primaryColor,
                thickness: 1,
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 150,
                      width: 200,
                      decoration: BoxDecoration(
                          //Car image
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  widget.orderData.car["carImage"])),
                          color: backgroundColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurStyle: BlurStyle.solid,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ]),
                    ),
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Car Name
                            Text(
                              widget.orderData.car["name"],
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            //car address
                            AutoSizeText(
                              widget.orderData.rentHouse["address"],
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.grey,
                                fontSize: 9,
                              ),
                              minFontSize: 2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  widget.orderData.car["plateNumber"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(
                              flex: 2,
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Start",
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        Text(
                                          dateFormat.format(DateTime.parse(
                                              widget.orderData.startDate)),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "End",
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        Text(
                                          dateFormat.format(DateTime.parse(
                                              widget.orderData.finishDate)),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Flexible(
                              flex: 7,
                              child: SizedBox(
                                height: 40,
                                width: 200,
                                child: MaterialButton(
                                  padding: const EdgeInsets.only(top: 3),
                                  onPressed: () {
                                    OrderApi.deleteOrder(widget.orderData.id);
                                    ref.read(carProvider.notifier).getCars();
                                    setState(() {});
                                  },
                                  color: Colors.red,
                                  child: const Text(
                                    "cancel",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: primaryColor,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Fare: ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'id',
                        symbol: 'Rp ',
                        decimalDigits: 2,
                      ).format(1600000),
                      style: const TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
