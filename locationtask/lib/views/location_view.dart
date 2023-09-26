// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locationtask/constants/colors.dart';
import 'package:locationtask/constants/custom_snackbar.dart';
import 'package:locationtask/services/location_service.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  String _crAddress = '🔍';
  bool isLoading = false;
  String status = 'Press button to get your location';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      drawer: const Drawer(),
      appBar: AppBar(
        title: const Text("Location Tracker 🗺️"),
        backgroundColor: primarycolor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              status,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 32),
            Text(
              _crAddress.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Robotto'),
            ),
          ],
        ),
      ),
      floatingActionButton: isLoading
          ? const CircularProgressIndicator(
              color: Colors.white,
            )
          : FloatingActionButton(
              backgroundColor: primarycolor,
              child: const Icon(Icons.location_on),
              onPressed: () async {
                final hasPermission =
                    await LocationService.handlePermission(context);
                if (!hasPermission) {
                  showSnackBar(context, 'Permission denied');
                  return;
                }
                setState(() {
                  isLoading = true;
                  status = 'getting location info';
                });
                Position position =
                    await LocationService.getCurrentPosition(context);
                setState(() {
                  isLoading = false;
                });
                String address =
                    await LocationService.getOriginalAddress(position);
                setState(() {
                  _crAddress = address;
                  isLoading = false;
                  status = 'location fetched 🚀';
                });
              }),
    );
  }
}
