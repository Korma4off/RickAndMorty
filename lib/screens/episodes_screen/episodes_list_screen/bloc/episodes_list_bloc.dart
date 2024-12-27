import 'package:flutter_application_3/models/episode.dart';
import 'package:flutter_application_3/repositories/episodes/episodes_local_storage.dart';
import 'package:flutter_application_3/repositories/episodes/episodes_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'episodes_list_event.dart';
part 'episodes_list_state.dart';

class EpisodesListBloc extends Bloc<EpisodesListEvent, EpisodesListState> {
  EpisodesListBloc() : super(EpisodesListInitial()) {
    on<LoadEpisodesList>((event, emit) async {
      try {
        if (state is! EpisodesListLoaded) {
          final episodesList =
              await EpisodesLocalStorage.instance.getEpisodes();
          emit(EpisodesListLoading(episodesList: episodesList));
        }
        final episodesList = await EpisodesRepository.instance.getData();
        emit(EpisodesListLoaded(episodesList: episodesList));
      } catch (e) {
        final episodesList = await EpisodesLocalStorage.instance.getEpisodes();
        emit(EpisodesListLoadingFailure(
            exception: e, episodesList: episodesList));
      } finally {
        //event.completer.complete();
      }
    });
  }

  //final characterGet = CharacterGet();
}
