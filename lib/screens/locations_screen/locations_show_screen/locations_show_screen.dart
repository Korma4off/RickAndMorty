import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/character.dart';
import 'package:flutter_application_3/screens/characters_screen/characters_show_screen/characters_show_screen.dart';
import 'package:flutter_application_3/screens/locations_screen/locations_show_screen/bloc/locations_show_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationsShowScreen extends StatefulWidget {
  const LocationsShowScreen({super.key, required this.id});
  final int id;
  @override
  State<LocationsShowScreen> createState() => _LocationsShowScreenState();
}

class _LocationsShowScreenState extends State<LocationsShowScreen> {
  final _locationShowBloc = LocationsShowBloc();

  Map<String, Color> statusColors = {
    'Alive': Colors.green,
    'Dead': Colors.red,
    'unknown': Colors.orange,
  };

  @override
  void initState() {
    _locationShowBloc.add(LoadLocations(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<LocationsShowBloc, LocationsShowState>(
      bloc: _locationShowBloc,
      builder: (context, state) {
        if (state is LocationsShowLoaded) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white, //change your color here
              ),
              title: Text(
                state.location.name,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
            ),
            body: Row(children: <Widget>[
              SizedBox(width: screenWidth * 0.05),
              Expanded(
                  child: ListView(children: [
                SizedBox(
                  width: screenWidth * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.location.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Type: ${state.location.type}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Dimension: ${state.location.dimension}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                TextWidget('Residents:', screenWidth, context),
                Column(
                  children:
                      ResidentsList(state.characters, screenWidth, context),
                )
              ])),
              SizedBox(width: screenWidth * 0.05)
            ]),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // ignore: non_constant_identifier_names
  Widget TextWidget(String str, double screenWidth, BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.9,
      child: Text(
        str,
        style: Theme.of(context).textTheme.headlineSmall,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  List<Widget> ResidentsList(
      List<Character> characters, double screenWidth, BuildContext context) {
    List<Widget> episodesList = [];
    for (Character character in characters) {
      episodesList.add(GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CharactersShowScreen(id: character.id)),
            );
          },
          child: TextWidget(character.name, screenWidth, context)));
    }
    return episodesList;
  }
}
