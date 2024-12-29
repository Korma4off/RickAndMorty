import 'package:flutter_application_3/models/character.dart';
import 'package:flutter_application_3/models/episode.dart';
import 'package:flutter_application_3/repositories/characters/characters_repository.dart';
import 'package:flutter_application_3/repositories/episodes/episodes_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'characters_show_event.dart';
part 'characters_show_state.dart';

class CharacterShowBloc extends Bloc<CharacterShowEvent, CharacterShowState> {
  CharacterShowBloc() : super(CharacterShowInitial()) {
    on<LoadCharacter>((event, emit) async {
      try {
        final character =
            await CharactersRepository.instance.getDataFromId(event.id);
        final episodes = await EpisodesRepository.instance.getData();
        emit(CharacterShowLoaded(character: character, episodes: episodes));
      } catch (e) {
        rethrow;
      }
    });
  }

  //final characterGet = CharacterGet();
}
