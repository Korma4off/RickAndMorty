part of 'locations_show_bloc.dart';

abstract class LocationsShowEvent {}

class LoadLocations extends LocationsShowEvent {
  LoadLocations(this.id);
  final int id;

  // List<Object?> get props => [completer];
}
