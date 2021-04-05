import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:outlook/models/Email.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../constants.dart';
import 'components/header.dart';

class ShipmentsPane extends StatefulWidget {
  const ShipmentsPane({
    Key key,
    this.email,
  }) : super(key: key);

  final CustomersQouteRequest email;

  @override
  _ShipmentsPaneState createState() => _ShipmentsPaneState();
}

class _ShipmentsPaneState extends State<ShipmentsPane> {
  dynamic statusUpdates;
  bool loading = true;
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    getUpdates();
  }

  getUpdates() async {
    var list = [];
    FirebaseFirestore.instance
        .collection('trackingUpdate')
        .where('id', isEqualTo: widget.email.tracking_code)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.id);
        print('fetching...');

        list.add(result.data());
        print('fetched data here');
        print(result.data());

        //id = result.id;
      });
      print(list);
      statusUpdates = list;
      print(statusUpdates);
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: Text('Loading...'),
            )
          : Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: 130,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Delivery Guy',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Status',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Route',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Expected Pickup',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: statusUpdates.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${index + 1}',
                                  ),
                                  Text(
                                    '${statusUpdates[index]['delivery_man_contact']}',
                                  ),
                                  Text(
                                    '${statusUpdates[index]['status']}',
                                  ),
                                  Text(
                                    '${statusUpdates[index]['route']}',
                                  ),
                                  Text(
                                    '${statusUpdates[index]['expected_delivery_date']}',
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
