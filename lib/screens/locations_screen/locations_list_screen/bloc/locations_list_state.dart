part of 'locations_list_bloc.dart';

abstract class LocationsListState {}

class LocationsListInitial extends LocationsListState {
  List<Object?> get props => [];
}

class LocationsListLoading extends LocationsListState {
  LocationsListLoading({required this.locationsList});
  final List<Location> locationsList;

  List<Object?> get props => [locationsList];
}

class LocationsListLoaded extends LocationsListState {
  LocationsListLoaded({required this.locationsList});
  final List<Location> locationsList;

  List<Object?> get props => [locationsList];
}

class LocationsListLoadingFailure extends LocationsListState {
  LocationsListLoadingFailure(
      {required this.exception, required this.locationsList});
  final Object exception;
  final List<Location> locationsList;

  List<Object?> get props => [exception, locationsList];
}
