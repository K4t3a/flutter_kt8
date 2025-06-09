abstract class AppEvents {}

class AppLoadDataEvent extends AppEvents {}

class AppReloadDataEvent extends AppEvents {}

class AppDeleteDataItemEvent extends AppEvents {
  final int itemIndex;
  AppDeleteDataItemEvent({required this.itemIndex});
}

class AppNavigateToScreenEvent extends AppEvents {}