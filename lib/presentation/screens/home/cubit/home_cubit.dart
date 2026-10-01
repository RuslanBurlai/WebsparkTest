import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/data/app_preferences.dart';
import 'package:webspark_test/data/data_repository.dart';
import 'package:webspark_test/domain/model/path_task.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
      {required AppPreference appPreference,
      required DataRepository dataRepository})
      : _appPreference = appPreference,
        _dataRepository = dataRepository,
        super(HomeInitial('')) {
    _initTextController();
  }

  final AppPreference _appPreference;
  final DataRepository _dataRepository;

  Future<void> _initTextController() async {
    final text = await _appPreference.apiUrl;
    emit(HomeInitial(text));
  }

  Future<void> onStartButtonPressed(String text) async {
    try {
      if (text.isNotEmpty) {
        final result = await _dataRepository.getTasksData(text);
        await _appPreference.saveUserURL(text);
        emit(HomeNavigateToProcessScreen(result));
      } else {
        emit(HomeError('Set valid API base URL in order to continue'));
      }
    } catch (e) {
      emit(HomeError('Set valid API base URL in order to continue'));
    }
  }
}
