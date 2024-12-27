import 'package:dio/dio.dart';
import 'package:flutter_application_3/models/character.dart';
import 'package:flutter_application_3/models/locations.dart';
import 'package:flutter_application_3/repositories/Locations/Locations_local_storage.dart';

class LocationsRepository {
  static final LocationsRepository instance = LocationsRepository._internal();
  factory LocationsRepository() => instance;
  LocationsRepository._internal();

  final dio = Dio();
  final storage = LocationsLocalStorage();

  Future<List<Location>> getData() async {
    List<Location> locations = [];
    try {
      final response =
          await dio.get('https://rickandmortyapi.com/api/location/');
      int pages = await response.data['info']['pages'];
      for (int i = 0; i < pages; i++) {
        final req =
            await dio.get('https://rickandmortyapi.com/api/location/?page=$i');
        var charList = await req.data['results'];
        for (int j = 0; j < charList.length; j++) {
          Location location = Location.fromMap(charList[j]);
          locations.add(location);
          storage.addLocation(location);
        }
      }
    } catch (_) {
      rethrow;
    }
    return locations;
  }

  Future<Location> getDataFromId(int id) async {
    try {
      final response =
          await dio.get('https://rickandmortyapi.com/api/location/$id');
      Location location = Location.fromMap(response.data);
      return location;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Character>> getCharactersFromId(int id) async {
    List<Character> characters = [];
    try {
      final response =
          await dio.get('https://rickandmortyapi.com/api/location/$id');
      List<dynamic> data = response.data['residents'];
      for (dynamic character in data) {
        var res = await dio.get(character);
        characters.add(Character.fromMap(res.data));
      }
      return characters;
    } catch (_) {
      rethrow;
    }
  }
}
