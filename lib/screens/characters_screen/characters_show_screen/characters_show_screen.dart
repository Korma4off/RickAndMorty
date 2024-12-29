// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/episode.dart';
import 'package:flutter_application_3/screens/characters_screen/characters_show_screen/bloc/characters_show_bloc.dart';
import 'package:flutter_application_3/screens/episodes_screen/episodes_show_screen/episodes_show_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersShowScreen extends StatefulWidget {
  const CharactersShowScreen({super.key, required this.id});
  final int id;
  @override
  State<CharactersShowScreen> createState() => _CharactersShowScreenState();
}

class _CharactersShowScreenState extends State<CharactersShowScreen> {
  final _characterShowBloc = CharacterShowBloc();

  Map<String, Color> statusColors = {
    'Alive': Colors.green,
    'Dead': Colors.red,
    'unknown': Colors.orange,
  };

  @override
  void initState() {
    _characterShowBloc.add(LoadCharacter(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<CharacterShowBloc, CharacterShowState>(
      bloc: _characterShowBloc,
      builder: (context, state) {
        if (state is CharacterShowLoaded) {
          return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.white, //change your color here
                ),
                title: Text(
                  state.character.name,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black,
              ),
              body: Row(children: [
                SizedBox(width: screenWidth * 0.05),
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: screenWidth * 0.05),
                      Row(children: <Widget>[
                        SizedBox(
                          width: screenWidth * 0.35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image(
                              image: NetworkImage(state.character.image),
                              width: screenWidth * 0.35,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.05),
                        SizedBox(
                          width: screenWidth * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.character.name,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 15,
                                    color: statusColors[state.character.status],
                                  ),
                                  Text(
                                    state.character.status,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              Text(
                                'Species: ${state.character.species}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                'Gender: ${state.character.gender}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                'Type: ${(state.character.type?.isEmpty ?? false) ? "unknown" : state.character.type}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: screenWidth * 0.05),
                      SizedBox(width: screenWidth * 0.05),
                      TextWidget(
                          'Origin: ${(state.character.origin?.isEmpty ?? false) ? "unknown" : state.character.origin!['name']}',
                          screenWidth,
                          context),
                      TextWidget(
                          'Location: ${(state.character.location?.isEmpty ?? false) ? "unknown" : state.character.location!['name']}',
                          screenWidth,
                          context),
                      TextWidget('Episodes:', screenWidth, context),
                      SizedBox(
                          width: screenWidth * 0.9,
                          child: Column(
                            children: EpisodesList(state.episodes,
                                state.character.episode, screenWidth, context),
                          )),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.05),
              ]));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

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

  List<Widget> EpisodesList(
      List<Episode> episodes,
      List<dynamic>? characterEpisodes,
      double screenWidth,
      BuildContext context) {
    List<Widget> episodesList = [];
    for (Episode episode in episodes) {
      if (characterEpisodes!.contains(episode.url)) {
        episodesList.add(GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EpisodesShowScreen(id: episode.id)),
              );
            },
            child: Column(children: [
              const SizedBox(height: 20),
              TextWidget(
                  '${episode.id + 1}. ${episode.name}', screenWidth, context)
            ])));
      }
    }
    return episodesList;
  }
}
