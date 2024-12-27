part of 'characters_list_screen.dart';

class CharactersListScreenTile extends StatefulWidget {
  const CharactersListScreenTile(
      {required this.character, required this.internet, super.key});
  final Character character;
  final bool internet;

  @override
  State<CharactersListScreenTile> createState() =>
      _CharactersListScreenTileState();
}

class _CharactersListScreenTileState extends State<CharactersListScreenTile> {
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
                  CharactersShowScreen(id: widget.character.id)),
        );
      },
      child: Row(children: <Widget>[
        SizedBox(width: screenWidth * 0.05),
        SizedBox(
          width: screenWidth * 0.35,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image(
              image: getImage() as ImageProvider<Object>,
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
                widget.character.name,
                style: Theme.of(context).textTheme.headlineMedium,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 15,
                    color: statusColors[widget.character.status],
                  ),
                  Text(
                    widget.character.status,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Text(
                'Species: ${widget.character.species}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Gender: ${widget.character.gender}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        SizedBox(width: screenWidth * 0.05)
      ]),
    );
  }

  Object getImage() => widget.internet
      ? NetworkImage(widget.character.image)
      : const AssetImage('assets/images/unknown.jpeg');
}
