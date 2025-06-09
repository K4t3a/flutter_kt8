import 'package:flutter_bloc/flutter_bloc.dart';

// События
abstract class AppEvents {}

class AppLoadDataEvent extends AppEvents {}

class AppReloadDataEvent extends AppEvents {}

class AppDeleteDataItemEvent extends AppEvents {
  AppDeleteDataItemEvent({required this.itemIndex});
  int itemIndex;
}

class AppNavigateToScreenEvent extends AppEvents {}

// Состояния
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoadingState extends AppStates {}

class AppLoadedState extends AppStates {
  AppLoadedState({required this.data});
  List<String> data;
}

class AppDeleteLoadingState extends AppLoadedState {
  AppDeleteLoadingState({required super.data});
}

class AppNavigateToScreenState extends AppStates {}

// Bloc
class AppBloc extends Bloc<AppEvents, AppStates> {
  List<String> data = [];

  AppBloc() : super(AppInitialState()) {
    on<AppLoadDataEvent>(_loadData);
    on<AppReloadDataEvent>(_reloadData);
    on<AppDeleteDataItemEvent>(_deleteDataItem);
    on<AppNavigateToScreenEvent>((event, emit) {
      emit(AppNavigateToScreenState());
    });
  }

  Future<void> _loadData(AppLoadDataEvent event, Emitter<AppStates> emit) async {
    emit(AppLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    data = ['Item 1', 'Item 2', 'Item 3'];
    emit(AppLoadedState(data: data));
  }

  Future<void> _reloadData(AppReloadDataEvent event, Emitter<AppStates> emit) async {
    emit(AppDeleteLoadingState(data: data));
    await Future.delayed(const Duration(seconds: 1));
    data = ['Item 1', 'Item 2', 'Item 3'];
    emit(AppLoadedState(data: data));
  }

  Future<void> _deleteDataItem(AppDeleteDataItemEvent event, Emitter<AppStates> emit) async {
    emit(AppDeleteLoadingState(data: data));
    await Future.delayed(const Duration(seconds: 1));
    data.removeAt(event.itemIndex);
    emit(AppLoadedState(data: data));
  }
}