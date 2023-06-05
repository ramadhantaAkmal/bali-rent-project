import 'package:bali_rent/style.dart';
import 'package:bali_rent/viewmodel/order_providers.dart';
import 'package:bali_rent/views/ui/orders_page/orders_widget/order_card.dart';
import 'package:bali_rent/views/ui/orders_page/orders_widget/order_carddone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/order_models/order.dart';
import '../../../viewmodel/history_providers.dart';
import 'orders_widget/order_cardupcoming.dart';

class OrdersMain extends ConsumerStatefulWidget {
  const OrdersMain({super.key});

  @override
  ConsumerState<OrdersMain> createState() => _OrdersMainState();
}

class _OrdersMainState extends ConsumerState<OrdersMain> {
  int _upcomingLength = 0;
  int _historyLength = 0;
  @override
  void initState() {
    ref.read(historyProvider);
    super.initState();
    _loadDataLength();
  }

  void _loadDataLength() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _historyLength =
          ref.read(historyProvider.notifier).filterOrders("done").length;
      _upcomingLength =
          ref.read(historyProvider.notifier).filterOrders("upcoming").length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: _builAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  AppBar _builAppBar(BuildContext context) {
    return AppBar(
      elevation: 2,
      bottomOpacity: 1.0,
      backgroundColor: themeColor,
      automaticallyImplyLeading: false,
      title: const Text(
        'Order History',
        style: TextStyle(
          color: secondaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            onTap: (value) {
              setState(() {
                _historyLength = ref
                    .read(historyProvider.notifier)
                    .filterOrders("done")
                    .length;
                _upcomingLength = ref
                    .read(historyProvider.notifier)
                    .filterOrders("upcoming")
                    .length;
              });
            },
            tabs: [
              const Tab(
                text: 'Active',
              ),
              Tab(
                text: 'Upcoming ($_upcomingLength)',
              ),
              Tab(text: 'History ($_historyLength)'),
            ],
            labelColor: primaryColor,
            unselectedLabelColor: Colors.black,
            dividerColor: primaryColor,
            indicatorColor: primaryColor,
            padding: const EdgeInsets.only(top: 18, left: 13, right: 30),
            labelStyle:
                const TextStyle(overflow: TextOverflow.visible, fontSize: 13),
            unselectedLabelStyle: const TextStyle(
              overflow: TextOverflow.visible,
            ),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                height: MediaQuery.of(context).size.height,
                width: 440,
                child: TabBarView(children: [
                  Consumer(
                    builder: (context, ref, _) {
                      final filtered = ref
                          .watch(historyProvider.notifier)
                          .filterOrders("active");

                      return filtered.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/emptylist.jpg'),
                                  ),
                                  Text(
                                    "The list is empty",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    context.debugDoingBuild
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : OrderCard(filtered[index]),
                                  ],
                                );
                              },
                              itemCount: filtered.length,
                              shrinkWrap: true,
                            );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final filtered = ref
                          .watch(historyProvider.notifier)
                          .filterOrders("upcoming");

                      return filtered.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/emptylist.jpg'),
                                  ),
                                  Text(
                                    "The list is empty",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    context.debugDoingBuild
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : UpcomingCard(filtered[index]),
                                  ],
                                );
                              },
                              itemCount: filtered.length,
                              shrinkWrap: true,
                            );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final filtered = ref
                          .watch(historyProvider.notifier)
                          .filterOrders("done");

                      return filtered.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: AssetImage(
                                        'assets/images/emptylist.jpg'),
                                  ),
                                  Text(
                                    "The list is empty",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    context.debugDoingBuild
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : OrderCardDone(filtered[index]),
                                  ],
                                );
                              },
                              itemCount: filtered.length,
                              shrinkWrap: true,
                            );
                    },
                  ),
                ])),
          ),
        ],
      ),
    );
  }
}
