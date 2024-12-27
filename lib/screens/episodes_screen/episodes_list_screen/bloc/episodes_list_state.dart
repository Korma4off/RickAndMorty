part of 'episodes_list_bloc.dart';

abstract class EpisodesListState {}

class EpisodesListInitial extends EpisodesListState {
  List<Object?> get props => [];
}

class EpisodesListLoading extends EpisodesListState {
  EpisodesListLoading({required this.episodesList});
  final List<Episode> episodesList;

  List<Object?> get props => [episodesList];
}

class EpisodesListLoaded extends EpisodesListState {
  EpisodesListLoaded({required this.episodesList});
  final List<Episode> episodesList;

  List<Object?> get props => [episodesList];
}

class EpisodesListLoadingFailure extends EpisodesListState {
  EpisodesListLoadingFailure(
      {required this.exception, required this.episodesList});
  final Object exception;
  final List<Episode> episodesList;

  List<Object?> get props => [exception, episodesList];
}
