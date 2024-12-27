part of 'episodes_show_bloc.dart';

abstract class EpisodesShowEvent {}

class LoadEpisodes extends EpisodesShowEvent {
  LoadEpisodes(this.id);
  final int id;

  // List<Object?> get props => [completer];
}
