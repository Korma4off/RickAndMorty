import 'dart:async';
import 'package:flutter_application_3/database.dart';
import 'package:flutter_application_3/models/locations.dart';

class LocationsLocalStorage {
  static final LocationsLocalStorage instance =
      LocationsLocalStorage._internal();
  factory LocationsLocalStorage() => instance;
  LocationsLocalStorage._internal();

  Future<List<Location>> getLocations() async {
    DatabaseHelper db = DatabaseHelper();
    var locations = await db.getObject('Locations');
    List<Location> locationsList = locations.isNotEmpty
        ? locations.map((c) => Location.fromMap(c)).toList()
        : [];
    return locationsList;
  }

  Future<Location> getLocationFromId(int id) async {
    DatabaseHelper db = DatabaseHelper();
    var location = await db.getObjectFromId('Locations', id);
    return Location.fromMap(location);
  }

  Future<int> addLocation(Location location) async {
    DatabaseHelper db = DatabaseHelper();
    var result = await db.addObject('Locations', location.toMap());
    return result;
  }

  Future<int> removeLocation(int id) async {
    DatabaseHelper db = DatabaseHelper();
    return await db.removeObject('Locations', id);
  }

  Future<int> updateLocation(Location location) async {
    DatabaseHelper db = DatabaseHelper();
    return await db.updateObject('Locations', location.toMap());
  }
}
