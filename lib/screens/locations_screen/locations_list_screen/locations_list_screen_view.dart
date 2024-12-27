part of 'locations_list_screen.dart';

class LocationsListScreenView extends StatefulWidget {
  const LocationsListScreenView({super.key, required this.locationsListBloc});
  final LocationsListBloc locationsListBloc;

  @override
  State<LocationsListScreenView> createState() =>
      _LocationsListScreenViewState();
}

class _LocationsListScreenViewState extends State<LocationsListScreenView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RefreshIndicator(
      child: BlocBuilder<LocationsListBloc, LocationsListState>(
        bloc: widget.locationsListBloc,
        builder: (context, state) {
          if (state is LocationsListLoaded) {
            return listBuilding(state, true);
          }
          if (state is LocationsListLoadingFailure) {
            return listBuilding(state, false);
          }
          if (state is LocationsListLoading) {
            return listBuilding(state, false);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      onRefresh: () async {
        widget.locationsListBloc.add(LoadLocationsList());
      },
    ));
  }

  Widget listBuilding(state, bool internet) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 16),
      itemCount: state.locationsList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final location = state.locationsList[index];
        return LocationsListScreenTile(location: location);
      },
    );
  }
}
