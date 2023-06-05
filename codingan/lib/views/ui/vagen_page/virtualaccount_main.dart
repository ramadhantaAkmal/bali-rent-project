import 'dart:developer';

import 'package:bali_rent/fetchs/order_fetch.dart';
import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../../../viewmodel/order_providers.dart';
import '../homescreen_page/homescreen_main.dart';

class VirtualAccountMain extends ConsumerStatefulWidget {
  const VirtualAccountMain({super.key});

  @override
  ConsumerState<VirtualAccountMain> createState() => _VirtualAccountMainState();
}

class _VirtualAccountMainState extends ConsumerState<VirtualAccountMain> {
  bool _fetch = true;
  bool _isBtnDisabled = true;
  String _vaText = "loading";
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

  void _launchUrl(url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  void _loadVA() async {
    while (_fetch) {
      var transaction = ref.watch(orderProvider);
      if (transaction["bank"] != null) {
        _vaText = transaction["va_num"];
        log("$transaction");
      }
      if (_vaText != "loading") {
        _fetch = false;
        setState(() {});
        return;
      }
      await Future.delayed(const Duration(seconds: 3));
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
              const Text(
                'Your Virtual Account Number',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Center(
                child: _vaText == "loading"
                    ? const CircularProgressIndicator()
                    : Text(
                        _vaText,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
              ),
              IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: _vaText));
                  },
                  icon: Icon(Icons.content_copy)),
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
                        setState(() {
                          _isBtnDisabled = false;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: primaryColor,
                      child: const Text(
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
                      onPressed: _isBtnDisabled
                          ? null
                          : () {
                              var transaction = ref.watch(orderProvider);
                              OrderApi.checkStatus(
                                  transaction["orderId"], transaction["token"]);
                              HomescreenMain.restartApp(context);
                              context.pushReplacement('/homescreen');
                            },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      disabledColor: Colors.grey,
                      color: primaryColor,
                      child: const Text(
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
