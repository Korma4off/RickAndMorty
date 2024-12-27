import 'package:flutter_application_3/models/locations.dart';
import 'package:flutter_application_3/repositories/locations/locations_local_storage.dart';
import 'package:flutter_application_3/repositories/locations/locations_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locations_list_event.dart';
part 'locations_list_state.dart';

class LocationsListBloc extends Bloc<LocationsListEvent, LocationsListState> {
  LocationsListBloc() : super(LocationsListInitial()) {
    on<LoadLocationsList>((event, emit) async {
      try {
        if (state is! LocationsListLoaded) {
          final locationsList =
              await LocationsLocalStorage.instance.getLocations();
          emit(LocationsListLoading(locationsList: locationsList));
        }
        final locationsList = await LocationsRepository.instance.getData();
        emit(LocationsListLoaded(locationsList: locationsList));
      } catch (e) {
        final locationsList =
            await LocationsLocalStorage.instance.getLocations();
        emit(LocationsListLoadingFailure(
            exception: e, locationsList: locationsList));
      } finally {
        //event.completer.complete();
      }
    });
  }

  //final characterGet = CharacterGet();
}
