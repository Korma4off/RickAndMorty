import 'package:flutter_application_3/models/character.dart';
import 'package:flutter_application_3/models/locations.dart';
import 'package:flutter_application_3/repositories/characters/characters_repository.dart';
import 'package:flutter_application_3/repositories/locations/locations_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locations_show_event.dart';
part 'locations_show_state.dart';

class LocationsShowBloc extends Bloc<LocationsShowEvent, LocationsShowState> {
  LocationsShowBloc() : super(LocationsShowInitial()) {
    on<LoadLocations>((event, emit) async {
      try {
        final location =
            await LocationsRepository.instance.getDataFromId(event.id);
        final characters = await CharactersRepository.instance.getData();
        emit(LocationsShowLoaded(location: location, characters: characters));
      } catch (e) {
        rethrow;
      }
    });
  }

  //final locationGet = locationGet();
}
