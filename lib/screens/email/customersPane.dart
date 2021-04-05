import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:outlook/models/Email.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../constants.dart';
import 'components/header.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({
    Key key,
    this.email,
  }) : super(key: key);

  final CustomersQouteRequest email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Header(),
              Divider(thickness: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(kDefaultPadding),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        maxRadius: 24,
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage(email.full_name),
                      ),
                      SizedBox(width: kDefaultPadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          text: email.full_name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .button,
                                          children: [
                                            TextSpan(
                                                text: "  ( ${email.email} )",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        email.tracking_code,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: kDefaultPadding / 2),
                                Text(
                                  email.request_date,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            SizedBox(height: kDefaultPadding),
                            LayoutBuilder(
                              builder: (context, constraints) => SizedBox(
                                width: constraints.maxWidth > 850
                                    ? 800
                                    : constraints.maxWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Personl Information",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 1),
                                    SizedBox(height: kDefaultPadding / 2),
                                    Row(
                                      children: [
                                        Text(
                                          'Cell Phone:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.cell_phone),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Home Phone:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.home_phone),
                                      ],
                                    ),
                                    Row(children: [
                                      Text(
                                        'Street Address:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(email.street_address),
                                    ]),
                                    Row(
                                      children: [
                                        Text(
                                          'City:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.city),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'State:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.state),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Zip Code:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.pickup_zipcode),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Pick Up Information",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 1),
                                    SizedBox(height: kDefaultPadding / 2),
                                    Row(
                                      children: [
                                        Text(
                                          'Pickup Location:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.pickup_location),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Pickup Street:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.pickup_street),
                                      ],
                                    ),
                                    Row(children: [
                                      Text(
                                        'Pickup City:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(email.pickup_city),
                                    ]),
                                    Row(
                                      children: [
                                        Text(
                                          'Pickup State:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.pickup_state),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Pickup Zipcode:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.pickup_zipcode),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Pickup Date:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.pickup_date),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Delivery Information",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 1),
                                    SizedBox(height: kDefaultPadding / 2),
                                    Row(
                                      children: [
                                        Text(
                                          'Delivery Location:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.delivery_location),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Delivery Street Address:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.delivery_street_address),
                                      ],
                                    ),
                                    Row(children: [
                                      Text(
                                        'Delivery City:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(email.delivery_city),
                                    ]),
                                    Row(
                                      children: [
                                        Text(
                                          'Delivery State:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.delivery_state),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Delivery Zipcode:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.delivery_zipcode),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Shipment Details",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Divider(thickness: 1),
                                    SizedBox(height: kDefaultPadding / 2),
                                    Row(
                                      children: [
                                        Text(
                                          'Quantity:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.quantity),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Type:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.type),
                                      ],
                                    ),
                                    Row(children: [
                                      Text(
                                        'Year:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(email.year),
                                    ]),
                                    Row(
                                      children: [
                                        Text(
                                          'Make:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.make),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Model:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        Text(email.model),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
