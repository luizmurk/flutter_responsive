import 'package:flutter/material.dart';

class CustomersQouteRequest {
  final String full_name,
      email,
      request_date,
      street_address,
      status,
      delivery_city,
      update_message,
      route,
      pickup_state,
      quantity,
      state,
      city,
      make,
      cell_phone,
      delivery_street_address,
      delivery_zipcode,
      expected_delivery_date,
      shipment_status,
      delivery_state,
      pickup_location,
      pickup_zipcode,
      home_phone,
      year,
      type,
      delivery_location,
      tracking_code,
      pickup_city,
      pickup_date,
      delivery_man_contact,
      pickup_street,
      model;

  CustomersQouteRequest(
      {this.full_name,
      this.email,
      this.request_date,
      this.street_address,
      this.status,
      this.delivery_city,
      this.update_message,
      this.route,
      this.pickup_state,
      this.quantity,
      this.state,
      this.city,
      this.make,
      this.cell_phone,
      this.delivery_street_address,
      this.delivery_zipcode,
      this.expected_delivery_date,
      this.shipment_status,
      this.delivery_state,
      this.pickup_location,
      this.pickup_zipcode,
      this.home_phone,
      this.year,
      this.type,
      this.delivery_location,
      this.tracking_code,
      this.pickup_city,
      this.pickup_date,
      this.delivery_man_contact,
      this.pickup_street,
      this.model});
}

List<CustomersQouteRequest> emails = List.generate(
  demo_data.length,
  (index) => CustomersQouteRequest(
    full_name: demo_data[index]['full_name'],
    email: demo_data[index]['email'],
    request_date: demo_data[index]['pickup_date'],
    street_address: demo_data[index]['street_address'],
    status: demo_data[index]['status'],
    delivery_city: demo_data[index]['delivery_city'],
    update_message: demo_data[index]['update_message'],
    route: demo_data[index]['route'],
    pickup_state: demo_data[index]['pickup_state'],
    quantity: demo_data[index]['quantity'],
    state: demo_data[index]['state'],
    city: demo_data[index]['city'],
    make: demo_data[index]['make'],
    cell_phone: demo_data[index]['cell_phone'],
    delivery_street_address: demo_data[index]['delivery_street_address'],
    delivery_zipcode: demo_data[index]['delivery_zipcode'],
    expected_delivery_date: demo_data[index]['expected_delivery_date'],
    shipment_status: demo_data[index]['shipment_status'],
    delivery_state: demo_data[index]['delivery_sate'],
    pickup_location: demo_data[index]['pickup_location'],
    pickup_zipcode: demo_data[index]['pickup_zipcode'],
    home_phone: demo_data[index]['home_phone'],
    year: demo_data[index]['year'],
    type: demo_data[index]['type'],
    delivery_location: demo_data[index]['delivery_location'],
    tracking_code: demo_data[index]['tracking_code'],
    pickup_city: demo_data[index]['pickup_city'],
    pickup_date: demo_data[index]['pickup_date'],
    delivery_man_contact: demo_data[index]['delivery_man_contact'],
    pickup_street: demo_data[index]['pickup_street'],
    model: demo_data[index]['model'],
  ),
);

List demo_data = [];
