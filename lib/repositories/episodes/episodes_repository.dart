import 'package:dio/dio.dart';
import 'package:flutter_application_3/models/character.dart';
import 'package:flutter_application_3/models/episode.dart';
import 'package:flutter_application_3/repositories/episodes/episodes_local_storage.dart';

class EpisodesRepository {
  static final EpisodesRepository instance = EpisodesRepository._internal();
  factory EpisodesRepository() => instance;
  EpisodesRepository._internal();

  final dio = Dio();
  final storage = EpisodesLocalStorage();

  Future<List<Episode>> getData() async {
    List<Episode> episodes = [];
    try {
      final response =
          await dio.get('https://rickandmortyapi.com/api/episode/');
      int pages = await response.data['info']['pages'];
      for (int i = 0; i < pages; i++) {
        final req =
            await dio.get('https://rickandmortyapi.com/api/episode?page=$i');
        var charList = await req.data['results'];
        for (int j = 0; j < charList.length; j++) {
          Episode episode = Episode.fromMap(charList[j]);
          episodes.add(episode);
          storage.addEpisode(episode);
        }
      }
    } catch (_) {
      rethrow;
    }
    return episodes;
  }

  Future<Episode> getDataFromId(int id) async {
    try {
      final response =
          await dio.get('https://rickandmortyapi.com/api/episode/$id');
      Episode episode = Episode.fromMap(response.data);
      return episode;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Character>> getCharactersFromId(int id) async {
    List<Character> characters = [];
    try {
      final response =
          await dio.get('https://rickandmortyapi.com/api/episode/$id');
      List<dynamic> data = response.data['characters'];
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
