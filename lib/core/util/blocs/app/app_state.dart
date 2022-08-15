part of 'app_cubit.dart';

@immutable
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppDatabaseInitializedState extends AppStates {}

class AppDatabaseTableCreatedState extends AppStates {}

class AppDatabaseOpenedState extends AppStates {}

class AppDatabaseTaskCreatedState extends AppStates {}

class AppDatabaseTaskUpdatedState extends AppStates {}

class AppDatabaseTaskStatusUpdatedState extends AppStates {}

class AppDatabaseTaskDeletedState extends AppStates {}

class AppDatabaseLoadingState extends AppStates {}

class AppDatabaseTasksState extends AppStates {}

class AppChangeModeState extends AppStates {}
