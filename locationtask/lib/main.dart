import 'package:flutter/material.dart';
import 'package:locationtask/views/location_view.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Location Tracker',
    home: LocationView(),
  ));
}
