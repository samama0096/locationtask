// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locationtask/constants/custom_snackbar.dart';

class LocationService {
  static Future<bool> handlePermission(BuildContext context) async {
    bool isServiceEnabled;
    LocationPermission permission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      showSnackBar(context, 'Location is disabled.');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar(context, 'Location is denied.');

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar(context, 'Location permission is denied.');
      return false;
    }
    return true;
  }

  static Future<Position> getCurrentPosition(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  static Future<String> getOriginalAddress(Position position) async {
    List<Placemark> places =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (places.isNotEmpty) {
      return places[0].name ?? 'Unable to get Location';
    }
    return 'Unable to get Location';
  }
}
