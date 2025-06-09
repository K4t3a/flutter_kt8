import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/app_bloc.dart';
import 'bloc/app_event.dart';
import 'bloc/app_state.dart';
import '../second_screen/second_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main Screen')),
      body: BlocConsumer<AppBloc, AppStates>(
        listener: (context, state) {
          if (state is AppNavigateToScreenState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SecondScreen()),
            );
          }
        },
        builder: (context, state) {
          if (state is AppLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AppLoadedState) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<AppBloc>().add(
                              AppDeleteDataItemEvent(itemIndex: index),
                            );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          state.data[index],
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  },
                ),
                if (state is AppDeleteLoadingState)
                  const Center(child: CircularProgressIndicator()),
              ],
            );
          }

          return const Center(child: Text('Что-то пошло не так...'));
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'refresh',
            onPressed: () {
              context.read<AppBloc>().add(AppReloadDataEvent());
            },
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'next',
            onPressed: () {
              context.read<AppBloc>().add(AppNavigateToScreenEvent());
            },
            child: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}