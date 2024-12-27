//import 'package:equatable/equatable.dart';

class Episode {
  final int id;
  final String name;
  // ignore: non_constant_identifier_names
  final String air_date;
  final String episode;
  final List<dynamic>? characters;

  Episode({
    required this.id,
    required this.name,
    // ignore: non_constant_identifier_names
    required this.air_date,
    required this.episode,
    this.characters,
  });

  factory Episode.fromMap(Map<String, dynamic> json) => Episode(
        id: json['id'],
        name: json['name'],
        air_date: json['air_date'],
        episode: json['episode'],
        characters: json['characters'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'air_date': air_date,
      'episode': episode,
    };
  }

  // @override
  // List<Object?> get props => [id, name, status, species, gender, image];
}
