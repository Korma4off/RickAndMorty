import 'dart:async';
import 'package:flutter_application_3/database.dart';
import 'package:flutter_application_3/models/episode.dart';

class EpisodesLocalStorage {
  static final EpisodesLocalStorage instance = EpisodesLocalStorage._internal();
  factory EpisodesLocalStorage() => instance;
  EpisodesLocalStorage._internal();

  Future<List<Episode>> getEpisodes() async {
    DatabaseHelper db = DatabaseHelper();
    var episodes = await db.getObject('Episodes');
    List<Episode> episodesList = episodes.isNotEmpty
        ? episodes.map((c) => Episode.fromMap(c)).toList()
        : [];
    return episodesList;
  }

  Future<Episode> getEpisodeFromId(int id) async {
    DatabaseHelper db = DatabaseHelper();
    var episode = await db.getObjectFromId('Episodes', id);
    return Episode.fromMap(episode);
  }

  Future<int> addEpisode(Episode episode) async {
    DatabaseHelper db = DatabaseHelper();
    var result = await db.addObject('Episodes', episode.toMap());
    return result;
  }

  Future<int> removeEpisode(int id) async {
    DatabaseHelper db = DatabaseHelper();
    return await db.removeObject('Episodes', id);
  }

  Future<int> updateEpisode(Episode episode) async {
    DatabaseHelper db = DatabaseHelper();
    return await db.updateObject('Episodes', episode.toMap());
  }
}
