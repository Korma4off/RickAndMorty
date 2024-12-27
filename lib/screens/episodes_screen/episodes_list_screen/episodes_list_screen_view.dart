part of 'episodes_list_screen.dart';

class EpisodesListScreenView extends StatefulWidget {
  const EpisodesListScreenView({super.key, required this.episodesListBloc});
  final EpisodesListBloc episodesListBloc;

  @override
  State<EpisodesListScreenView> createState() => _EpisodesListScreenViewState();
}

class _EpisodesListScreenViewState extends State<EpisodesListScreenView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
      child: BlocBuilder<EpisodesListBloc, EpisodesListState>(
        bloc: widget.episodesListBloc,
        builder: (context, state) {
          if (state is EpisodesListLoaded) {
            return listBuilding(state, true);
          }
          if (state is EpisodesListLoadingFailure) {
            return listBuilding(state, false);
          }
          if (state is EpisodesListLoading) {
            return listBuilding(state, false);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      onRefresh: () async {
        widget.episodesListBloc.add(LoadEpisodesList());
      },
    ));
  }

  Widget listBuilding(state, bool internet) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      itemCount: state.episodesList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final episode = state.episodesList[index];
        return EpisodesListScreenTile(episode: episode);
      },
    );
  }
}
