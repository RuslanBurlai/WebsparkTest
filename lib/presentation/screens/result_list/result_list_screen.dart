import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/core/navigation/routes.dart';
import 'package:webspark_test/domain/model/path_result.dart';
import 'package:webspark_test/presentation/screens/result_list/cubit/result_list_cubit.dart';

class ResultListScreen extends StatelessWidget {
  const ResultListScreen({super.key, required this.pathResult});

  final List<PathResult> pathResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result list screen'),
      ),
      body: BlocProvider(
        create: (context) => ResultListCubit(),
        child: BlocBuilder<ResultListCubit, ResultListState>(
          builder: (context, state) {
            return ListView.builder(
              itemCount: pathResult.length,
              itemBuilder: (context, index) =>
                  _buildPathResultCell(context, index),
            );
          },
        ),
      ),
    );
  }

  Column _buildPathResultCell(BuildContext context, int index) {
    return Column(
      children: [
        ListTile(
          titleAlignment: ListTileTitleAlignment.center,
          contentPadding: EdgeInsets.zero,
          onTap: () async {
            await Navigator.pushNamed(context, previewScreen,
                arguments: pathResult[index]);
          },
          title: Text(
              pathResult[index].hasPath
                  ? pathResult[index].formattedPath
                  : 'Path not available',
              textAlign: TextAlign.center),
        ),
        const Divider(
          color: Colors.grey,
          height: 1,
        )
      ],
    );
  }
}
