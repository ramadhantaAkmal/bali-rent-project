import 'package:flutter/material.dart';
import 'package:bali_rent/style.dart';
import 'package:go_router/go_router.dart';

class DetailMain extends StatelessWidget {
  const DetailMain({super.key});

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
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: Offset(3, 4),
                    color: Colors.black26),
              ],
            ),
            child: Image(
              image: AssetImage('assets/images/toyota-avanza.jpeg'),
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
                      'Toyota Avanza',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Available',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      'Jimbaran, Kecamatan Kuta Selatan',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    'Rp. 399.000/day',
                    style: TextStyle(
                      fontSize: 15,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I Made Cakra',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
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
                      onPressed: () {},
                      icon: Icon(
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.phone,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            color: Colors.grey,
          ),
          Text(
            'Car Info',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(
            flex: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 90),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.airline_seat_recline_normal,
                          color: primaryColor,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '6 seat',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Image(
                          image: AssetImage('assets/images/manual.png'),
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Manual',
                          style: TextStyle(fontSize: 14),
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
                        Icon(
                          Icons.local_gas_station,
                          color: primaryColor,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Petrol 95',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Image(
                          image: AssetImage('assets/images/Tire.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '2 WD',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Spacer(
            flex: 10,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: MaterialButton(
              onPressed: () {
                context.push('/homescreen/detail/order');
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
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
