part of 'locations_show_bloc.dart';

abstract class LocationsShowState {}

class LocationsShowInitial extends LocationsShowState {
  List<Object?> get props => [];
}

class LocationsShowLoading extends LocationsShowState {
  LocationsShowLoading({required this.location, required this.characters});
  final Location location;
  final List<Character> characters;

  List<Object?> get props => [location];
}

class LocationsShowLoaded extends LocationsShowState {
  LocationsShowLoaded({required this.location, required this.characters});
  final Location location;
  final List<Character> characters;

  List<Object?> get props => [location];
}

class LocationsShowLoadingFailure extends LocationsShowState {
  LocationsShowLoadingFailure(
      {required this.exception,
      required this.location,
      required this.characters});
  final Object exception;
  final Location location;
  final List<Character> characters;

  List<Object?> get props => [exception, location];
}
