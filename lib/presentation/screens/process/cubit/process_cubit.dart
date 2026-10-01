import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/data/data_repository.dart';
import 'package:webspark_test/domain/model/path_result.dart';
import 'package:webspark_test/domain/model/path_task.dart';
import 'package:webspark_test/domain/model/result.dart';
import 'package:webspark_test/domain/model/submission_result.dart';
import 'package:webspark_test/domain/services/shortest_path_service.dart';

part 'process_state.dart';

class ProcessCubit extends Cubit<ProcessState> {
  ProcessCubit(this._dataRepository, this._shortestPathService, this._tasks)
      : super(ProcessInitial()) {
    _calculatePathTasks();
  }

  final Iterable<PathTask> _tasks;
  final DataRepository _dataRepository;
  final ShortestPathService _shortestPathService;
  List<PathResult> _calculatedTaskResult = [];

  void _calculatePathTasks() {
    _calculatedTaskResult = _shortestPathService.solveAll(_tasks);
  }

  Future<void> onSendResultButtonPressed(BuildContext context) async {
    try {
      emit(ProcessLoading());
      if (_calculatedTaskResult.isNotEmpty) {
        final resultSummary = _calculatedTaskResult.map(
            (e) => SubmissionResult(e.id, Result(e.path, e.formattedPath)));
        await _dataRepository.submitTaskResults(resultSummary);
        
        emit(NavigateToResultListScreen(_calculatedTaskResult));
      }
      emit(ProcessCalculated(_calculatedTaskResult));
    } catch (e) {
      emit(ProcessError('Error'));
    }
  }

  void displayMessage() => emit(ProcessCalculated(_calculatedTaskResult));
}
