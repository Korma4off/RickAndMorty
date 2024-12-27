import 'package:flutter/material.dart';
import 'package:flutter_application_3/database.dart';
import 'package:flutter_application_3/screens/characters_screen/characters_list_screen/characters_list_screen.dart';
import 'package:flutter_application_3/screens/episodes_screen/episodes_list_screen/episodes_list_screen.dart';
import 'package:flutter_application_3/screens/locations_screen/locations_list_screen/locations_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const CharactersListScreen(),
        '/episodes': (BuildContext context) => const EpisodesListScreen(),
        '/locations': (BuildContext context) => const LocationsListScreen(),
      },
    );
  }
}
