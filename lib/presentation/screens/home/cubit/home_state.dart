part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {
  final String userURL;
  HomeInitial(this.userURL);
}

final class HomeError extends HomeState {
  final String error;
  HomeError(this.error);
}

final class HomeNavigateToProcessScreen extends HomeState {
  final Iterable<PathTask?> tasks;

  HomeNavigateToProcessScreen(this.tasks);
}
