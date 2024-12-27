import 'package:flutter/material.dart';
import 'package:flutter_application_3/header.dart';
import 'package:flutter_application_3/models/character.dart';
import 'package:flutter_application_3/screens/characters_screen/characters_list_screen/bloc/character_list_bloc.dart';
import 'package:flutter_application_3/screens/characters_screen/characters_show_screen/characters_show_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'characters_list_screen_view.dart';
part 'characters_list_screen_tile.dart';

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({super.key});

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  final _charactersListBloc = CharacterListBloc();

  @override
  void initState() {
    _charactersListBloc.add(LoadCharacterList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          const Header(activePage: 'Characters'),
          CharactersListScreenView(
            charactersListBloc: _charactersListBloc,
          ),
        ],
      ),
    ));
  }
}
