import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as gps;

class LocationService {
  /// Singleton instance
  static final LocationService instance = LocationService._internal();

  /// Private constructor for Singletor instance
  LocationService._internal();

  /// This method will detect latitude and longitude using geolocator package,
  /// And finally return the address
  Future<Position?> getCurrentLocation() async {
    try {
      /// checking location service is enabled or not
      /// if not enabled then return
      bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        debugPrint(
          "\nLocation service is not enabled. Opening location settings.\n",
        );
        await gps.Location().requestService();
        isServiceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!isServiceEnabled) {
          await Geolocator.openLocationSettings();
          return null;
        }
      }

      /// checking location permission and ask necessary permission
      LocationPermission locationPermission =
          await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied ||
          locationPermission == LocationPermission.deniedForever) {
        debugPrint(
          "\nLocation permission is denied. Asking for location permission.\n",
        );

        /// if denied then ask permission
        locationPermission = await Geolocator.requestPermission();

        /// if permission denied then return
        if (locationPermission == LocationPermission.denied ||
            locationPermission == LocationPermission.deniedForever) {
          debugPrint("\nSorry! Location permission is denied.\n");
          return null;
        }
      }

      /// Detecting gps location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      debugPrint(
        "\nLatitude : ${position.latitude}\nLongitude : ${position.longitude}\n",
      );

      return position;
    } catch (error, stackTrace) {
      debugPrint(
        "\n==================\nError getting location: $error\n$stackTrace\n"
        "======================\n",
      );
    }

    return null;
  }

  /// This method will convert latitude and longitude to human readable address
  Future<String?> getCurrentAddress() async {
    String? currentLocation;

    try {
      final Position? position = await getCurrentLocation();

      if (position != null) {
        /// Detecting location place marks using latitude and longitude
        List<Placemark> placeMarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        /// if successfully location detected then return it
        if (placeMarks.isNotEmpty) {
          Placemark place = placeMarks.first;
          currentLocation =
              "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
          debugPrint("\nCurrent location : $currentLocation\n");
          return currentLocation;
        }
        /// can not found any location using the latitude and longitude
        else {
          debugPrint(
            "\nCould not find any area name according the location,\nlatitude : ${position.latitude} and longitude : ${position.longitude}.\n",
          );
          return null;
        }
      } else {
        debugPrint("\nCould not detect location\n");
        return null;
      }
    } catch (error) {
      debugPrint("\nError while getting current address : $error\n");
    }
    return null;
  }

  /// Get address using latitude and longitude
  Future<String?> getAddress({
    required double latitude,
    required double longitude,
  }) async {
    String? address;
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        latitude,
        longitude,
      );

      /// if successfully location detected then return it
      if (placeMarks.isNotEmpty) {
        Placemark place = placeMarks.first;
        address =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}, ${place.country}";
        debugPrint("\nAddress found : $address\n");
        return address;
      }
      /// can not found any location using the latitude and longitude
      else {
        debugPrint(
          "\nCould not find any area name according the location,\nlatitude : ${latitude} and longitude : ${longitude}.\n",
        );
        return null;
      }
    } catch (error) {
      debugPrint("\nError while getting Address : $error\n");
    }
    return null;
  }
}
