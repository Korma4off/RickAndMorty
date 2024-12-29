//import 'package:equatable/equatable.dart';

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String? type;
  final String gender;
  final Map<String, dynamic>? origin;
  final Map<String, dynamic>? location;
  final List<dynamic>? episode;
  final String image;
  final String? url;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    this.type,
    this.origin,
    this.location,
    this.episode,
    this.url,
  });

  factory Character.fromMap(Map<String, dynamic> json) => Character(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: json['origin'],
        location: json['location'],
        episode: json['episode'],
        image: json['image'],
        url: json['url'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
      'image': image
    };
  }

  // @override
  // List<Object?> get props => [id, name, status, species, gender, image];
}
