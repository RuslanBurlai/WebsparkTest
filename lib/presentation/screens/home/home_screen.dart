import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/core/navigation/routes.dart';
import 'package:webspark_test/presentation/screens/home/cubit/home_cubit.dart';
import 'package:webspark_test/presentation/widgets/async_text_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (_) => HomeCubit(
            appPreference: context.read(), dataRepository: context.read()),
        child: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) async {
            if (state is HomeNavigateToProcessScreen) {
              await Navigator.pushNamed(context, processScreen,
                  arguments: state.tasks);
            }
          },
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              state is HomeInitial ? _controller.text = state.userURL : '';
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state is HomeError ? Text(state.error) : const SizedBox(),
                      _buildTextField(),
                      const Spacer(),
                      _buildStartButton(context)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Row _buildTextField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.compare_arrows_rounded),
        const SizedBox(width: 20),
        Expanded(
          child: TextField(controller: _controller),
        )
      ],
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return AsyncTextButton(
      onPressed: () async =>
          await context.read<HomeCubit>().onStartButtonPressed(_controller.text),
      child: const Text(
        'Start counting process',
      ),
    );
  }
}
