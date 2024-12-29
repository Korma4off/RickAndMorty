import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/character.dart';
import 'package:flutter_application_3/screens/characters_screen/characters_list_screen/characters_list_screen.dart';
import 'package:flutter_application_3/screens/characters_screen/characters_show_screen/characters_show_screen.dart';
import 'package:flutter_application_3/screens/episodes_screen/episodes_show_screen/bloc/episodes_show_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodesShowScreen extends StatefulWidget {
  const EpisodesShowScreen({super.key, required this.id});
  final int id;
  @override
  State<EpisodesShowScreen> createState() => _EpisodesShowScreenState();
}

class _EpisodesShowScreenState extends State<EpisodesShowScreen> {
  final _episodeShowBloc = EpisodesShowBloc();

  Map<String, Color> statusColors = {
    'Alive': Colors.green,
    'Dead': Colors.red,
    'unknown': Colors.orange,
  };

  @override
  void initState() {
    _episodeShowBloc.add(LoadEpisodes(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<EpisodesShowBloc, EpisodesShowState>(
      bloc: _episodeShowBloc,
      builder: (context, state) {
        if (state is EpisodesShowLoaded) {
          return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.white, //change your color here
                ),
                title: Text(
                  state.episode.name,
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
                          state.episode.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Type: ${state.episode.air_date}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Dimension: ${state.episode.episode}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  TextWidget('Characters', screenWidth, context),
                  Column(
                    children: CharactersList(state.characters,
                        state.episode.characters, screenWidth, context),
                  ),
                  SizedBox(width: screenWidth * 0.05)
                ])),
              ]));
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
  List<Widget> CharactersList(
      List<Character> characters,
      List<dynamic>? episodeCharacters,
      double screenWidth,
      BuildContext context) {
    List<Widget> episodesList = [];
    for (Character character in characters) {
      if (episodeCharacters!.contains(character.url)) {
        episodesList.add(GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CharactersShowScreen(id: character.id)),
              );
            },
            child: Column(children: [
              const SizedBox(height: 20),
              CharactersListScreenTile(character: character, internet: true)
            ])));
      }
    }
    return episodesList;
  }
  // // ignore: non_constant_identifier_names
  // List<Widget> CharactersList(
  //     List<Character> characters,
  //     List<dynamic>? episodeCharacters,
  //     double screenWidth,
  //     BuildContext context) {
  //   List<Widget> episodesList = [];
  //   for (Character character in characters) {
  //     if (episodeCharacters!.contains(character.url)) {
  //       episodesList.add(GestureDetector(
  //           onTap: () {
  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) =>
  //                       CharactersShowScreen(id: character.id)),
  //             );
  //           },
  //           child: TextWidget(character.name, screenWidth, context)));
  //     }
  //   }
  //   return episodesList;
  // }
}
