import 'package:flutter/material.dart';

class CustomersQouteRequest {
  final String full_name, email, request_date, address;

  CustomersQouteRequest({
    this.full_name,
    this.email,
    this.request_date,
    this.address,
  });
}

List<CustomersQouteRequest> emails = List.generate(
  demo_data.length,
  (index) => CustomersQouteRequest(
    full_name: demo_data[index]['full_name'],
    email: demo_data[index]['email'],
    request_date: demo_data[index]['request_date'],
    address: demo_data[index]['street_address'],
  ),
);

List demo_data = [];
