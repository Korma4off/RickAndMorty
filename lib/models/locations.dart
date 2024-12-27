//import 'package:equatable/equatable.dart';

class Location {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<dynamic>? residents;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    this.residents,
  });

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        dimension: json['dimension'],
        residents: json['residents'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'dimension': dimension,
    };
  }

  // @override
  // List<Object?> get props => [id, name, status, species, gender, image];
}
