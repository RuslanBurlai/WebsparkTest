import 'package:webspark_test/data/api_client.dart';
import 'package:webspark_test/data/app_preferences.dart';
import 'package:webspark_test/data/model/api_response.dart';
import 'package:webspark_test/domain/model/path_task.dart';
import 'package:webspark_test/domain/model/submission_result.dart';

abstract interface class DataRepository {
  Future<ApiResponse?> submitTaskResults(
      Iterable<SubmissionResult> result);
  Future<Iterable<PathTask?>> getTasksData(String url);
}

class DataRepositoryImpl implements DataRepository{
  DataRepositoryImpl(
      {required ApiClient apiClient, required AppPreference appPreference})
      : _apiClient = apiClient,
        _appPreference = appPreference;

  final ApiClient _apiClient;
  final AppPreference _appPreference;

  @override
  Future<ApiResponse?> submitTaskResults(
      Iterable<SubmissionResult> result) async {
    final url = await _appPreference.apiUrl;
    final gameListJson = result.map((game) => game.toMap()).toList();
    return await _apiClient.post(url, body: gameListJson);
  }

  @override
  Future<Iterable<PathTask?>> getTasksData(String url) async {
    final response = await _apiClient.get(url);
    final tasks = response.body.map((p) => PathTask.fromJson(p));
    return tasks;
  }
}
