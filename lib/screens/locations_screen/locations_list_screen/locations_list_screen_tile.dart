part of 'locations_list_screen.dart';

class LocationsListScreenTile extends StatefulWidget {
  const LocationsListScreenTile({required this.location, super.key});
  final Location location;

  @override
  State<LocationsListScreenTile> createState() =>
      _LocationsListScreenTileState();
}

class _LocationsListScreenTileState extends State<LocationsListScreenTile> {
  Map<String, Color> statusColors = {
    'Alive': Colors.green,
    'Dead': Colors.red,
    'unknown': Colors.orange,
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LocationsShowScreen(id: widget.location.id)),
        );
      },
      child: Row(children: <Widget>[
        SizedBox(width: screenWidth * 0.05),
        SizedBox(
          width: screenWidth * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.location.name,
                style: Theme.of(context).textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Type: ${widget.location.type}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Dimension: ${widget.location.dimension}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.05)
      ]),
    );
  }
}
