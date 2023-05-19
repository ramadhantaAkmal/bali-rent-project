import 'package:flutter/material.dart';
import 'package:bali_rent/style.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class OrderMain extends StatefulWidget {
  const OrderMain({super.key});

  @override
  State<OrderMain> createState() => _OrderMainState();
}

class _OrderMainState extends State<OrderMain> {
  dynamic _dateCount;

  late int _totalFare;
  late int _fare;
  late int _totalFareConfirm;

  @override
  void initState() {
    // TODO: implement initState
    _fare = 399000;
    _totalFare = _fare;
    _totalFareConfirm = _totalFare;
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    try {
      var to = args.value.endDate;
      var from = args.value.startDate;
      _dateCount = (to.difference(from).inHours / 24).round() ?? 0;
      if (_dateCount > 0) {
        _totalFare = _dateCount * _fare;
      } else {
        _totalFare = _fare;
      }
    } catch (_) {}
  }

  dynamic _onSubmit(Object? obj) {
    setState(() {
      _totalFareConfirm = _totalFare;
    });
  }

  void _onCancel() {
    setState(() {
      _totalFare = _totalFareConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Book Date',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(20),
            child: SfDateRangePicker(
              confirmText: "SUBMIT",
              startRangeSelectionColor: primaryColor,
              endRangeSelectionColor: primaryColor,
              rangeSelectionColor: secondaryColor,
              showActionButtons: true,
              showTodayButton: true,
              todayHighlightColor: primaryColor,
              headerStyle:
                  const DateRangePickerHeaderStyle(backgroundColor: themeColor),
              minDate: DateTime.now(),
              maxDate: DateTime.now().add(const Duration(days: 21)),
              onCancel: _onCancel,
              onSubmit: _onSubmit,
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedDate: DateTime.now(),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Fare:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 2,
                ).format(_totalFare),
                style: const TextStyle(
                  fontSize: 19,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: MaterialButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: primaryColor,
              child: const Text(
                'Book It!',
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
