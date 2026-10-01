part of 'process_cubit.dart';

@immutable
sealed class ProcessState {}

final class ProcessInitial extends ProcessState {}

final class ProcessCalculated extends ProcessState {
  final List<PathResult> calculatedTaskResult;

  ProcessCalculated(this.calculatedTaskResult);
}

final class ProcessLoading extends ProcessState {}

final class NavigateToResultListScreen extends ProcessState {
  final List<PathResult> results;

  NavigateToResultListScreen(this.results);
}

final class ProcessError extends ProcessState {
  ProcessError(this.error);

  final String error;
}
