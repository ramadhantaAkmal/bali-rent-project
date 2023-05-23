import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../viewmodel/order_providers.dart';

class VirtualAccountMain extends ConsumerStatefulWidget {
  const VirtualAccountMain({super.key});

  @override
  ConsumerState<VirtualAccountMain> createState() => _VirtualAccountMainState();
}

class _VirtualAccountMainState extends ConsumerState<VirtualAccountMain> {
  bool _fetch = true;
  String _vaText = "Loading...";
  final Uri _urlBca =
      Uri.parse('https://simulator.sandbox.midtrans.com/bca/va/index');
  final Uri _urlPermata =
      Uri.parse('https://simulator.sandbox.midtrans.com/permata/va/index');

  @override
  void initState() {
    ref.read(orderProvider);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loadVA();
    });

    super.initState();
  }

  void _launchUrl(_url) async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  void _loadVA() async {
    while (_fetch) {
      var transaction = ref.watch(orderProvider);
      if (transaction["bank"] != null) {
        _vaText = transaction["va_num"];
        print(transaction);
      }
      if (_vaText != "Loading...") {
        _fetch = false;
        setState(() {});
        return;
      }
      await Future.delayed(Duration(seconds: 3));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Virtual Account Number',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Center(
                child: Text(
                  _vaText,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: MaterialButton(
                      onPressed: () {
                        var transaction = ref.watch(orderProvider);
                        if (transaction["bank"] == "bca") {
                          _launchUrl(_urlBca);
                        } else {
                          _launchUrl(_urlPermata);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: primaryColor,
                      child: Text(
                        'Open Midtrans',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: primaryColor,
                      child: Text(
                        'Back to Homescreen',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
