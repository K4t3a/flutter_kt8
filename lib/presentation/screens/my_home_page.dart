import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/app_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {
        if (state is AppNavigateToScreenState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const OtherScreen()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Главный экран'),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: Colors.deepPurpleAccent,
                tooltip: 'Перейти',
                onPressed: () {
                  context.read<AppBloc>().add(AppNavigateToScreenEvent());
                },
              ),
              TextButton(
                onPressed: () {
                  context.read<AppBloc>().add(AppNavigateToScreenEvent());
                },
                child: const Text(
                  'Перейти',
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (state is AppLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.deepPurpleAccent),
                );
              }

              if (state is AppLoadedState) {
                return Stack(
                  children: [
                    ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return _HoverableDeleteItem(
                          text: state.data[index],
                          onTap: () {
                            context.read<AppBloc>().add(AppDeleteDataItemEvent(itemIndex: index));
                          },
                        );
                      },
                    ),
                    if (state is AppDeleteLoadingState)
                      const Center(
                        child: CircularProgressIndicator(color: Colors.deepPurpleAccent),
                      )
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () {
              context.read<AppBloc>().add(AppReloadDataEvent());
            },
            child: const Icon(Icons.refresh),
          ),
        );
      },
    );
  }
}

class _HoverableDeleteItem extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _HoverableDeleteItem({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_HoverableDeleteItem> createState() => _HoverableDeleteItemState();
}

class _HoverableDeleteItemState extends State<_HoverableDeleteItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: _hovering ? Colors.deepPurpleAccent.withOpacity(0.7) : Colors.grey[900],
            borderRadius: BorderRadius.circular(16),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: Colors.deepPurpleAccent.withOpacity(0.6),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class OtherScreen extends StatelessWidget {
  const OtherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Другой экран'),
        backgroundColor: Colors.pink,
      ),
      body: const Center(
        child: Text(
          'Это другой экран',
          style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 24),
        ),
      ),
    );
  }
}
