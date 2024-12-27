import 'package:flutter/material.dart';
import 'package:flutter_application_3/header.dart';
import 'package:flutter_application_3/models/locations.dart';
import 'package:flutter_application_3/screens/locations_screen/locations_list_screen/bloc/locations_list_bloc.dart';
import 'package:flutter_application_3/screens/locations_screen/locations_show_screen/locations_show_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locations_list_screen_view.dart';
part 'locations_list_screen_tile.dart';

class LocationsListScreen extends StatefulWidget {
  const LocationsListScreen({super.key});

  @override
  State<LocationsListScreen> createState() => _LocationsListScreenState();
}

class _LocationsListScreenState extends State<LocationsListScreen> {
  final _locationsListBloc = LocationsListBloc();

  @override
  void initState() {
    _locationsListBloc.add(LoadLocationsList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const Header(activePage: 'Locations'),
          LocationsListScreenView(
            locationsListBloc: _locationsListBloc,
          ),
        ],
      ),
    ));
  }
}
