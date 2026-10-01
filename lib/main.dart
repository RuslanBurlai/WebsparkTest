import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webspark_test/data/api_client.dart';
import 'package:webspark_test/data/app_preferences.dart';
import 'package:webspark_test/data/data_repository.dart';
import 'package:webspark_test/core/navigation/routes.dart';
import 'package:webspark_test/domain/services/shortest_path_service.dart';
import 'package:webspark_test/presentation/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  runApp(WebSparkTestApp(preference: pref));
}

class WebSparkTestApp extends StatelessWidget {
  const WebSparkTestApp({required SharedPreferences preference, super.key})
      : _pref = preference;

  final SharedPreferences _pref;

  @override
  Widget build(BuildContext context) {
    final appPreference = AppPreference(_pref);
    return MultiProvider(
      providers: [
        Provider<DataRepository>(
          create: (context) {
            final api = HttpApiClientImpl();
            return DataRepositoryImpl(apiClient: api, appPreference: appPreference);
          },
        ),
        Provider<ShortestPathService>(create: (context) => ShortestPathServiceImpl()),
        Provider<AppPreference>(create: (context) => appPreference)
      ],
      child: MaterialApp(
        routes: routes,
        onGenerateRoute: onGenerateRoute,
        theme: lightTheme,
      ),
    );
  }
}
