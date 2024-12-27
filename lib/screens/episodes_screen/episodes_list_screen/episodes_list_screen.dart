import 'package:flutter/material.dart';
import 'package:flutter_application_3/header.dart';
import 'package:flutter_application_3/models/episode.dart';
import 'package:flutter_application_3/screens/episodes_screen/episodes_list_screen/bloc/episodes_list_bloc.dart';
import 'package:flutter_application_3/screens/episodes_screen/episodes_show_screen/episodes_show_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'episodes_list_screen_view.dart';
part 'episodes_list_screen_tile.dart';

class EpisodesListScreen extends StatefulWidget {
  const EpisodesListScreen({super.key});

  @override
  State<EpisodesListScreen> createState() => _EpisodesListScreenState();
}

class _EpisodesListScreenState extends State<EpisodesListScreen> {
  final _episodesListBloc = EpisodesListBloc();

  @override
  void initState() {
    _episodesListBloc.add(LoadEpisodesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const Header(activePage: 'Episodes'),
          EpisodesListScreenView(
            episodesListBloc: _episodesListBloc,
          ),
        ],
      ),
    ));
  }
}
