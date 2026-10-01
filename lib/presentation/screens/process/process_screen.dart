import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/core/navigation/routes.dart';
import 'package:webspark_test/data/data_repository.dart';
import 'package:webspark_test/domain/model/path_task.dart';
import 'package:webspark_test/domain/services/shortest_path_service.dart';
import 'package:webspark_test/presentation/screens/process/cubit/process_cubit.dart';
import 'package:webspark_test/presentation/widgets/async_text_button.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({required this.tasks, super.key});

  final Iterable<PathTask> tasks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Process screen')),
      body: BlocProvider(
        create: (context) => ProcessCubit(context.read<DataRepository>(),
            context.read<ShortestPathService>(), tasks),
        child: BlocListener<ProcessCubit, ProcessState>(
          listener: (context, state) async {
            if (state is NavigateToResultListScreen) {
              await Navigator.pushNamed(context, resultListScreen,
                  arguments: state.results);
            }
          },
          child: BlocBuilder<ProcessCubit, ProcessState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        _buildHeader(state, context),
                        _buildLoadingBar(context),
                      ],
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  _buildCircularLoading(state),
                  state is ProcessError ? Text(state.error) : const SizedBox(),
                  const Spacer(),
                  _buildSubmitButton(state, context),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ProcessState state, BuildContext context) {
    return state is ProcessCalculated || state is ProcessLoading
        ? Text(
            'All you calculation has finished, you can send your results to server',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge)
        : SizedBox();
  }

  TweenAnimationBuilder<int> _buildLoadingBar(BuildContext context) {
    return TweenAnimationBuilder(
      tween: IntTween(begin: 0, end: 100),
      duration: const Duration(seconds: 2),
      builder: (context, int value, _) =>
          Text('$value%', style: Theme.of(context).textTheme.bodyLarge),
      onEnd: () => WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ProcessCubit>().displayMessage();
      }),
    );
  }

  SizedBox _buildCircularLoading(ProcessState state) {
    return state is ProcessLoading
        ? const SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(color: Colors.lightBlue),
          )
        : const SizedBox();
  }

  Widget _buildSubmitButton(ProcessState state, BuildContext context) {
    return state is ProcessCalculated || state is ProcessLoading
        ? Padding(
            padding: const EdgeInsets.all(12),
            child: AsyncTextButton(
              onPressed: () async {
                await context
                    .read<ProcessCubit>()
                    .onSendResultButtonPressed(context);
              },
              child: const Text(
                'Send results to server',
              ),
            ),
          )
        : const SizedBox();
  }
}
