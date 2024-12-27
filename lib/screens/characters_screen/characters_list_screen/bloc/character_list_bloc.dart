import 'package:flutter_application_3/models/character.dart';
import 'package:flutter_application_3/repositories/characters/characters_repository.dart';
import 'package:flutter_application_3/repositories/characters/characters_local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListBloc() : super(CharacterListInitial()) {
    on<LoadCharacterList>((event, emit) async {
      try {
        if (state is! CharacterListLoaded) {
          final charactersList =
              await CharactersLocalStorage.instance.getCharacters();
          emit(CharacterListLoading(charactersList: charactersList));
        }
        final charactersList = await CharactersRepository.instance.getData();
        emit(CharacterListLoaded(charactersList: charactersList));
      } catch (e) {
        final charactersList =
            await CharactersLocalStorage.instance.getCharacters();
        emit(CharacterListLoadingFailure(
            exception: e, charactersList: charactersList));
      } finally {
        //event.completer.complete();
      }
    });
  }

  //final characterGet = CharacterGet();
}
