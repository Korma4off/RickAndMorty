part of 'episodes_list_screen.dart';

class EpisodesListScreenTile extends StatefulWidget {
  const EpisodesListScreenTile({required this.episode, super.key});
  final Episode episode;

  @override
  State<EpisodesListScreenTile> createState() => _EpisodesListScreenTileState();
}

class _EpisodesListScreenTileState extends State<EpisodesListScreenTile> {
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
              builder: (context) => EpisodesShowScreen(id: widget.episode.id)),
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
                widget.episode.name,
                style: Theme.of(context).textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Type: ${widget.episode.air_date}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Dimension: ${widget.episode.episode}',
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
