import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvents, AppStates> {
  List<String> data = [];

  AppBloc() : super(AppInitialState()) {
    on<AppLoadDataEvent>(_loadData);
    on<AppReloadDataEvent>(_reloadData);
    on<AppDeleteDataItemEvent>(_deleteItem);
    on<AppNavigateToScreenEvent>(_navigate);
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

  Future<void> _deleteItem(AppDeleteDataItemEvent event, Emitter<AppStates> emit) async {
    emit(AppDeleteLoadingState(data: data));
    await Future.delayed(const Duration(seconds: 1));
    data.removeAt(event.itemIndex);
    emit(AppLoadedState(data: data));
  }

  Future<void> _navigate(AppNavigateToScreenEvent event, Emitter<AppStates> emit) async {
    emit(AppNavigateToScreenState());
  }
}