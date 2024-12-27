import 'package:dio/dio.dart';
import 'package:flutter_application_3/models/character.dart';
import 'package:flutter_application_3/models/episode.dart';
import 'package:flutter_application_3/repositories/characters/characters_local_storage.dart';

class CharactersRepository {
  static final CharactersRepository instance = CharactersRepository._internal();
  factory CharactersRepository() => instance;
  CharactersRepository._internal();

  final dio = Dio();
  final storage = CharactersLocalStorage();

  Future<List<Character>> getData() async {
    List<Character> characters = [];
    try {
      final response =
          await dio.get('https://rickandmortyapi.com/api/character/');
      int pages = await response.data['info']['pages'];
      for (int i = 0; i < pages; i++) {
        final req =
            await dio.get('https://rickandmortyapi.com/api/character/?page=$i');
        var charList = await req.data['results'];
        for (int j = 0; j < charList.length; j++) {
          Character character = Character.fromMap(charList[j]);
          characters.add(character);
          storage.addCharacter(character);
        }
      }
    } catch (_) {
      rethrow;
    }
    return characters;
  }

  Future<Character> getDataFromId(int id) async {
    try {
      final response =
          await dio.get('https://rickandmortyapi.com/api/character/$id');
      Character character = Character.fromMap(response.data);
      return character;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Episode>> getEpisodesFromId(int id) async {
    List<Episode> episodes = [];
    try {
      final response =
          await dio.get('https://rickandmortyapi.com/api/character/$id');
      List<dynamic> data = response.data['episode'];
      for (dynamic episode in data) {
        var res = await dio.get(episode);
        episodes.add(Episode.fromMap(res.data));
      }
      return episodes;
    } catch (_) {
      rethrow;
    }
  }
}
