part of 'characters_show_bloc.dart';

abstract class CharacterShowState {}

class CharacterShowInitial extends CharacterShowState {
  List<Object?> get props => [];
}

class CharacterShowLoading extends CharacterShowState {
  CharacterShowLoading({required this.character, required this.episodes});
  final Character character;
  final List<Episode> episodes;

  List<Object?> get props => [character];
}

class CharacterShowLoaded extends CharacterShowState {
  CharacterShowLoaded({required this.episodes, required this.character});
  final Character character;
  final List<Episode> episodes;

  List<Object?> get props => [character];
}

class CharacterShowLoadingFailure extends CharacterShowState {
  CharacterShowLoadingFailure(
      {required this.episodes,
      required this.exception,
      required this.character});
  final Object exception;
  final Character character;
  final List<Episode> episodes;

  List<Object?> get props => [exception, character];
}
