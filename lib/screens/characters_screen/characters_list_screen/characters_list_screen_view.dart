part of 'characters_list_screen.dart';

class CharactersListScreenView extends StatefulWidget {
  const CharactersListScreenView({super.key, required this.charactersListBloc});
  final CharacterListBloc charactersListBloc;

  @override
  State<CharactersListScreenView> createState() =>
      _CharactersListScreenViewState();
}

class _CharactersListScreenViewState extends State<CharactersListScreenView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
      child: BlocBuilder<CharacterListBloc, CharacterListState>(
        bloc: widget.charactersListBloc,
        builder: (context, state) {
          if (state is CharacterListLoaded) {
            return listBuilding(state, true);
          }
          if (state is CharacterListLoadingFailure) {
            return listBuilding(state, false);
          }
          if (state is CharacterListLoading) {
            return listBuilding(state, false);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      onRefresh: () async {
        widget.charactersListBloc.add(LoadCharacterList());
      },
    ));
  }

  Widget listBuilding(state, bool internet) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      itemCount: state.charactersList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final character = state.charactersList[index];
        return CharactersListScreenTile(
            character: character, internet: internet);
      },
    );
  }
}
