abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingState extends AppStates {}

class AppLoadedState extends AppStates {
  final List<String> data;
  AppLoadedState({required this.data});
}

class AppDeleteLoadingState extends AppLoadedState {
  AppDeleteLoadingState({required super.data});
}

class AppNavigateToScreenState extends AppStates {}