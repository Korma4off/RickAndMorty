part of 'episodes_show_bloc.dart';

abstract class EpisodesShowState {}

class EpisodesShowInitial extends EpisodesShowState {
  List<Object?> get props => [];
}

class EpisodesShowLoading extends EpisodesShowState {
  EpisodesShowLoading({required this.episode, required this.characters});
  final Episode episode;
  final List<Character> characters;

  List<Object?> get props => [episode];
}

class EpisodesShowLoaded extends EpisodesShowState {
  EpisodesShowLoaded({required this.episode, required this.characters});
  final Episode episode;
  final List<Character> characters;

  List<Object?> get props => [episode];
}

class EpisodesShowLoadingFailure extends EpisodesShowState {
  EpisodesShowLoadingFailure(
      {required this.exception,
      required this.episode,
      required this.characters});
  final Object exception;
  final Episode episode;
  final List<Character> characters;

  List<Object?> get props => [exception, episode];
}
