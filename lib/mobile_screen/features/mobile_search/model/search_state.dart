part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<DocumentSnapshot> results;

  SearchSuccess(this.results);
}
final class SearchError extends SearchState {}
