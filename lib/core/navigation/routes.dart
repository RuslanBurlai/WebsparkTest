import 'package:flutter/material.dart';
import 'package:webspark_test/domain/model/path_result.dart';
import 'package:webspark_test/domain/model/path_task.dart';
import 'package:webspark_test/presentation/screens/home/home_screen.dart';
import 'package:webspark_test/presentation/screens/preview/preview_screen.dart';
import 'package:webspark_test/presentation/screens/process/process_screen.dart';
import 'package:webspark_test/presentation/screens/result_list/result_list_screen.dart';

const processScreen = '/process_screen';
const resultListScreen = '/result_list_screen';
const previewScreen = '/preview_screen';

final routes = {
  '/': (_) => const HomeScreen(title: 'Home screen'),
};

MaterialPageRoute? Function(dynamic settings) onGenerateRoute = (settings) {
  if (settings.name == processScreen) {
    final args = settings.arguments as Iterable<PathTask>;
    return MaterialPageRoute(
      builder: (context) {
        return ProcessScreen(
          tasks: args,
        );
      },
    );
  }
  if (settings.name == resultListScreen) {
    final args = settings.arguments as List<PathResult>;
    return MaterialPageRoute(
      builder: (context) {
        return ResultListScreen(
          pathResult: args,
        );
      },
    );
  }
  if (settings.name == previewScreen) {
    final args = settings.arguments as PathResult;
    return MaterialPageRoute(
      builder: (context) {
        return PreviewScreen(
          pathResult: args,
        );
      },
    );
  }
  assert(false, 'Need to implement ${settings.name}');
  return null;
};
