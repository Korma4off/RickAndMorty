part of 'characters_show_bloc.dart';

abstract class CharacterShowEvent {}

class LoadCharacter extends CharacterShowEvent {
  LoadCharacter(this.id);
  final int id;

  // List<Object?> get props => [completer];
}
