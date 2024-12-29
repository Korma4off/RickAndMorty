import 'package:flutter_application_3/models/character.dart';
import 'package:flutter_application_3/models/episode.dart';
import 'package:flutter_application_3/repositories/characters/characters_repository.dart';
import 'package:flutter_application_3/repositories/episodes/episodes_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'episodes_show_event.dart';
part 'episodes_show_state.dart';

class EpisodesShowBloc extends Bloc<EpisodesShowEvent, EpisodesShowState> {
  EpisodesShowBloc() : super(EpisodesShowInitial()) {
    on<LoadEpisodes>((event, emit) async {
      try {
        final episode =
            await EpisodesRepository.instance.getDataFromId(event.id);

        final characters = await CharactersRepository.instance.getData();

        emit(EpisodesShowLoaded(episode: episode, characters: characters));
      } catch (e) {
        rethrow;
      }
    });
  }

  //final episodeGet = episodeGet();
}
